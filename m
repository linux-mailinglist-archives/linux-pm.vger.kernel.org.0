Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F31471551A4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 05:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBGEwg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 23:52:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41853 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGEwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 23:52:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id l19so989633qtq.8
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2020 20:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zD+SD3a85WaBxn1quERCa86dJtVc2O8o6GA7qwBXCJo=;
        b=uddvL1JO80blrtkaBfjv1aHwZ4HIytAKy0DI5CT9/O4us4MST76ZlsrdKQysjeImgW
         w3Rx79nuHFyMRNvG7GnsVnVipDncm8zE7nRpEr7FqIPPz+nnKLNEXI2N76W3/ZLZkT5Z
         Y+BlQr+helxKkejSPCoOc9+BTLIWiwLQ03l+TqRQxvE+nKlsNfS120O2c1Iubg5+ZFQO
         mLIoBeBnxdYYchquUqH0Cg9qF9NKVYhKYgC1vSkUjq5URuH7BKhqIKwelatUjTN1YoQl
         aI//XrgBlQA4abFi3U/VDYgOreY2cfEO+w03A5k1j7T7RMvtX94WDRb/ZOl/0/s+XH7w
         IDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zD+SD3a85WaBxn1quERCa86dJtVc2O8o6GA7qwBXCJo=;
        b=XAMHFRLhrQELYdFAlJ/wjlY2yMGbQNvJbiT0znHOb2KPPEa8Ar9m4lq+CUqZ1EfVac
         2WeY5HmEQtlEM0uIUNeXfhaiPM6vRYh0bXj2ovu5koMUzWRNaD/zPPczrvyCFeCkwquB
         CPu6OfdUgAK/daL9uneY2pa9Nde/Tp9hKj6MdbsI9/KviH2wXwqOnvmb0zDEOAzzVpYB
         tcbGFME0UrHZmhoUSa83X6NdP/a2zOJswtoxS6yiAkYFD1aDTnUEz1pKuplI+O+eJziZ
         SY3YOU8R+Yj/FeQImOtGruyaKLcs52GMSENYlzVdY2mSaJ5sl4exUMQytWaeTmku6t9V
         oF+Q==
X-Gm-Message-State: APjAAAVI2gS6d1NWz61okGxPicpS9Uw7xWLXn2dgY7vUQbT4lFoVkjKE
        JnQmeELa/gEfAwCEWnzhQC5DpGnqG6/Hlcv8iRmlRQ==
X-Google-Smtp-Source: APXvYqxdMLigY2gCSUFZRs79VGs+uC4dThA5WCs4e+pUPAKLGhvcheCYWpetzZ/p8JD1bZZO+ae2gLnu+ndNSyfimRU=
X-Received: by 2002:ac8:59:: with SMTP id i25mr5804123qtg.110.1581051155016;
 Thu, 06 Feb 2020 20:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com> <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com>
 <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
 <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
 <CADnq5_OObnKTP7-tBmPz75R5qXs8ubRxgfX-qkBnzqcox0TZyQ@mail.gmail.com>
 <CAD8Lp44FKuEsmdK+zDX_-ZYQEnqjQM-z6nnfE-CJ62mutd+scA@mail.gmail.com> <CADnq5_PNGr4=MqpBeKbhxJ-gpniSCj7L0wO5_V6mjuwpKoaCAg@mail.gmail.com>
In-Reply-To: <CADnq5_PNGr4=MqpBeKbhxJ-gpniSCj7L0wO5_V6mjuwpKoaCAg@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 7 Feb 2020 12:52:23 +0800
Message-ID: <CAD8Lp47vOdyG+BSzFy2URULz4icXYHW7SMW9zBEt4nfz804XTw@mail.gmail.com>
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

On Thu, Jan 16, 2020 at 11:15 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> It's just papering over the problem.  It would be better from a power
> perspective for the driver to just not suspend and keep running like
> normal.  When the driver is not suspended runtime things like clock
> and power gating are active which keep the GPU power at a minimum.

Until we have a better solution, are there any strategies we could
apply here to avoid the suspend as you say?
e.g. DMI quirk these products to disable suspend? Or disable suspend
on all s2idle setups?

This would certainly be better than the current situation of the
machine becoming unusable on resume.

> I talked to our sbios team and they seem to think our S0ix
> implementation works pretty differently from Intel's.  I'm not really
> an expert on this area however.  We have a new team ramping on up this
> for Linux however.

Thanks for following up on this internally! Can I lend a product
sample to the new team so that they have direct access?

Daniel
