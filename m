Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD2F108823
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 06:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfKYFSM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 00:18:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37366 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKYFSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 00:18:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id e187so11657805qkf.4
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2019 21:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxoPFJpfdFPGzCh7S8c0UjDSOfZgv1geNk+cSpTg93A=;
        b=qqwQ83fEGtuJ/caSJw10t/dKGcP2GbkM+PF1XwPrvLYUOABioklJPjXq74oG7P2q3w
         iDzgrv0a97x3WS2G/BLl6W0qqEPfzXtnranE777UVyXyxql9KKMDn2uzJyjMNNAx4thu
         YoyL6NTJ+xnt4zxCXEOGZziIQmhxzn98rYkKrtkTkGw9BHdkOHBl+5fq84UvXU+xkUIw
         YeZiX33IWfkpmKSPUjalajkDuqump5K1H0wckc3AJ/nxf4FDe1QiXwdU2Lial+6LTaQs
         1SvwINb9oS0DlRiLdljff/m3Yv9fyObdtYS3aGWTjHPQF1gtZLki8mSiIXd8t4AF1C3A
         JPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxoPFJpfdFPGzCh7S8c0UjDSOfZgv1geNk+cSpTg93A=;
        b=reIZAGEWZEWZw/iGUZP5DkAgv7AhxHG1P5kJwoftcstsUCyIWohRzlm+V5F8UjUaGd
         NmrpBu2YEGhVZJBMIbkMMwhMMKMY9httPNwAM5b+p2RZ0eU7qmhQ8Yz/xA9YaOlyL2O6
         x63YJwUVrnE0KqTB85t+u4nbLYfBQfySMxLsUhrtmTe6BHPi3TUZA/7OyOJH/nLSu36M
         Vynsauvd8flRPDsxQJy6/7Rond/Vq0SEvb4Uk14NtliJg7ia3COLMiwphMG0+sRE1f0E
         nCvdaiIZ/mr3Csn+G012n8HjeDqlNuvVv1QHMehDTKXRYLziMdIX6WBdbdJteYMe7XpJ
         gFmA==
X-Gm-Message-State: APjAAAU4+n9y6oBTOmMpuqxfKCHVoPiIIH7UdkJoE1dyM9yxFagiiStH
        oY+uQ5ZRlZMIHlhTzMUcwfLhvOgzhW1LzyQnh4ezGg==
X-Google-Smtp-Source: APXvYqw2AQtWJ1rxhi+gFVMKsY1xEeG7JlJZ3Dqg/h6yR8lXjZuzC8siyXYp8ipfy1+snxUBB+72udZxnRjiimvG71w=
X-Received: by 2002:a05:620a:12c3:: with SMTP id e3mr24416696qkl.14.1574659090155;
 Sun, 24 Nov 2019 21:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com> <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com> <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
In-Reply-To: <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 25 Nov 2019 13:17:59 +0800
Message-ID: <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset asic when going into suspend
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 22, 2019 at 11:32 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> Do these patches help?
> https://patchwork.freedesktop.org/patch/341775/
> https://patchwork.freedesktop.org/patch/341968/

Unfortunately not. The original issue still exists (dead gfx after
resume from s2idle) and also when I trigger execution of the suspend
or runtime suspend routines the power usage increases around 1.5W as
before.

Have you confirmed that amdgpu s2idle is working on platforms you have in hand?

Thanks
Daniel
