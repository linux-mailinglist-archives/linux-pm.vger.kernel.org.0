Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59A37124B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfGWHH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 03:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731529AbfGWHH0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 03:07:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A7262238C;
        Tue, 23 Jul 2019 07:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865646;
        bh=I9GiZXE2H1wDJFSDkAROBQrcosUY6dtwFNXmoTPtFPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xGr+4b9vi406nkBHR1ek44I2ERI8lhm37rIiuO+AessO4HP5kbDFyP0NHQKu08fiN
         0jafzQmzA08zs/ckvyG6I5SNJAbRJv0Gjhti7ede6oxQbzdNj2RIZpI0ZDNDFuG7L1
         7Vb3Fm4YX4IDSgRQJYqL+z5BfTczoGKVt3WgxPZg=
Date:   Tue, 23 Jul 2019 09:07:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: Re: [PATCH 1/2 V2] power: sysfs: Remove wakeup_abort_count attribute.
Message-ID: <20190723070723.GE27629@kroah.com>
References: <20190722182451.GB24412@kroah.com>
 <20190722223337.36199-1-ravisadineni@chromium.org>
 <20190722223337.36199-2-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722223337.36199-2-ravisadineni@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 03:33:36PM -0700, Ravi Chandra Sadineni wrote:
> wakeup_abort_count and wakeup_count sysfs entries print the
> same (wakeup_count) attribute. This patch removes the duplicate
> wakeup_abort_count sysfs entry.

Are you sure that userspace is not using this "duplicate" entry?  Have
you searched userspace tools to verify this?

thanks,

greg k-h
