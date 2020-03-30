Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FC19779C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgC3JQm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 05:16:42 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:39935 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbgC3JQm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 05:16:42 -0400
Received: by mail-yb1-f181.google.com with SMTP id h205so8642554ybg.6
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2020 02:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ih5Z51ea9CdLOkgrinM9yKV4FR/mbNeIlMKvCb0jTPs=;
        b=HB05v7mPPv+NmyFaktVrQ5MNwPOo6xzpTi6s07NfSIajOLzN8cj4x0w0WMeyk+3hKk
         HaHwyUmJ/xtMFG4W3X4SMcS4t2r9ePicWK9+e9hY03+EqjYItp0JxPicIvM6uDTOkKhn
         pa+ZFiPfr6ipekqx13G5roFZOZg0pWy78PxNEm6OpW9wpsxsfgKbWygU4qRQSLVjIKeL
         acBSEikCLULPybgzp9gcQH8MC8eOy+VhDhTKwPM22VEWlijApbmeJrvt/BWpJdPR272K
         oUGhw0rQDw1aZJPm7TGaRdfP2QzchqGUi/mZT1EBSWvpZb6HPPLWAPhGJcURUcg2Lpbt
         6p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ih5Z51ea9CdLOkgrinM9yKV4FR/mbNeIlMKvCb0jTPs=;
        b=l39NfCFYkE+n4s3Tv3nFv/XMI6SVWtRN5y/2K0Hg27PMw4TN5xipuHE0nm9ub2MeVp
         aroq2CcNTlnwV1RlUgq7ttXQFseZQ7TPPJk1qB2m2dyWEmWkE1Ax9CM8VP7ExN3d4Vco
         JaEwH+dralt4w4rN+YVLWyasPeaMGlwDJRSbn+mVpZZcJLqVIu+pYSPYi4Jw+cliSUX5
         ladBeWcO8ppo7JJo83BcHe1VJ+tZ1zZqapkKZ8ZOEi/5E/lL26ciMdyagttQI0ZO2Vpu
         6f/nCRLp/nw/+rzvBuwILjnT2M6GCf+LZPccLAXXEOj1yI4Tx8TDTwZSZOU16jS04xfx
         rtaw==
X-Gm-Message-State: ANhLgQ3YFG0VPiJUpP6r3yoNCYpVssKmb84qzTT8Q7iXOWGgh7kAr94E
        LHdMaBvX+0+/uPClFaJ1sdkUJt3dzoVUUjKKT9YuoeOp
X-Google-Smtp-Source: ADFU+vtqL10eA4+th9gLtHeby+XK0cFP4LJjzpU2lCa0L1sijXak8/73WX6+P/5wv4DtB7yEHch+4LsI9tu4mqAxqNw=
X-Received: by 2002:a25:ce8b:: with SMTP id x133mr17926650ybe.241.1585559800452;
 Mon, 30 Mar 2020 02:16:40 -0700 (PDT)
MIME-Version: 1.0
From:   pdev embedded <pdev.embedded@gmail.com>
Date:   Mon, 30 Mar 2020 11:16:28 +0200
Message-ID: <CA+-Ga+e+LYW42jR3nGt+p8mxwT92Q1EwJvSrJpXHWbNA=shiaA@mail.gmail.com>
Subject: suspend to ram order of operations
To:     linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In reading through the archives, I found the discussion of sys_sync()
and making the call optional, but I am still searching for a discussion
of why the operations are ordered the way they are.
1.) (optionally) sys_sync
2.) freeze user space
3.) freeze kernel threads

On an embedded system running Android where there are user space
processes (not under wakelock control) that generate a lot of IO,
freezing user space first helps reduce the time taken by sys_sync().
I believe this is because buffers are no longer being continually dirtied.

What was the rationale for the ordering of operations when suspending to ram?

If there is a lot of user-space filesystem activity, would
it not result in fewer dirty filesystem pages if enter_state()
ordered the operations as:
1.) freeze user space
2.) sys_sync
3.) freeze kernel threads

What am I missing?

Thank you
-Peter
