Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840811ED409
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgFCQQH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 12:16:07 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:43572 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgFCQQH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 12:16:07 -0400
Received: by mail-oo1-f45.google.com with SMTP id n31so604943ooi.10;
        Wed, 03 Jun 2020 09:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Vxn+FjB/uZOo05O2K5geDoSeOoBfcm/lAO32rEYhUNo=;
        b=E5BTwD8lG9kXzRl+XzMmdDv0CGTN+xz9MmecwdQpE7gzgfuj1oXD6sThb7UNvIIHFM
         OFWgiT67KnpPoRB99D3ftKLPqSZjbX+TE6X9OXF03sqfIhFfXCyx2bbjPU+H8mhrF4A+
         3QNFicG0s9oigya7BGeW2XLla5xuszSXqlLAFpG7pr8AUHlUmW3J9N1pZkKlSFODF8fc
         njDFB1afJmnJptya4x3CNxCBigrFQDLYXTR9h/EfHyrCwSz6FPWshd380yrsycflTUWo
         zF1mvAeeT7KDU7YAFnaj4jlhizuSRxBq6aOlfGElwk6WgfbZxaaeFW4VKIDKltTn4vBZ
         AP8A==
X-Gm-Message-State: AOAM5327XMwXtKiZwovO0BbwXMOI9V/cWfdLDw/IpWuincxQQ+P7R+3e
        csb7AHJP9ASN9Wp83J6g5YndAL4LaQtJjRSMysk=
X-Google-Smtp-Source: ABdhPJxw/Pnp3nDj6jnUi3o5Zz0u1oBqUw/9QDv9mZ5BdrX2beN5NLul+BkgpakXsob6ohmeLTazz2ECPSnPm5kk7Eg=
X-Received: by 2002:a4a:96f1:: with SMTP id t46mr520597ooi.75.1591200964789;
 Wed, 03 Jun 2020 09:16:04 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 18:15:53 +0200
Message-ID: <CAJZ5v0gA9Egmff0y4yTm2UH=ge+jJH1nMbLhTsRbUtP=+m8OLg@mail.gmail.com>
Subject: Problematic BT commit in Linux 5.7
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marcel,

Unfortunately, we are observing system suspend failures on multiple
lab machines as reported in the BZ entry at

https://bugzilla.kernel.org/show_bug.cgi?id=207629

which is due to the following commit:

commit dd522a7429b07e4441871ae75ebbfcf53635bdd4
Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed Mar 11 08:54:02 2020 -0700

    Bluetooth: Handle LE devices during suspend

Ostensibly, this is because the BT firmware on the machines in
question does not match the new kernel code, but the firmware update
requirement is not entirely obvious to the users and the steps to take
in order to upgrade the firmware are not clear.

Apart from the above, failing system suspend for a reason like a
protocol timeout isn't really user-friendly, because the user may just
have closed the lid of a laptop and is expecting the system to be
suspended (so it may go into a backpack or similar).  Yes, the driver
may not be able to suspend its device gracefully, but failing the
entire system suspend really is a big deal and should be treated as a
last-resort type of action.

As stated in the BZ above, reverting the above commit along with
"Bluetooth: Pause discovery and advertising during suspend"
(4867bd007d25a8dfd4ffc558534f7aec8b361789) makes the issue go away, so
can you please consider doing that?

Alternatively, would it be possible to address the issue in a way that
would not require many users to update firmware on their systems?

Cheers,
Rafael
