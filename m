Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6390E12007D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 10:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLPJAr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 04:00:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40578 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLPJAr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 04:00:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id t17so5194551qtr.7
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qbT+I3jm/2znfx77rItPHA5w5yjCMeZJROKsiWB1gc=;
        b=zIlhGEr6sueDlec+SsoI3zWPpi4Nv3bf842JXqAfjxNMrahRhW//FxbL0HYYRSkooN
         x9v99HFGa8JOfAHCEDtWd/Eak1J1dK8+dEgR/LNPq8jlcMH5z5QKl29pThUrWXcl15Di
         GzC9za+SPVtQRqgOp8B/jvRRKspsNQAE5KnwMlRoD68wSaT2MUj4FiSbP+SJZJn/H+HC
         90WwBS5If2YXeNAxBR1Tm4MZfQ93jrn8DalTFEMzE9xjn8Dj92MYEL4653Hfu0VL1zWo
         kx5eqHdB7tE9x9csuK5RcbMyR9YQHvOMzW+MKIKpcZNxNejBH+/V6di2iWcN085zuzUS
         hCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qbT+I3jm/2znfx77rItPHA5w5yjCMeZJROKsiWB1gc=;
        b=KWvd3togHtCz1CLNVW3cf55emsFMpabXP3oddMeQapjWXz+DIOpkEJLHmdx2LygJIf
         6oGEoRQSnrtk6J9uYfWxv7XrreYDF4r35Xc2/Pi+WIcOpMUeoPhuM+I18hG/1LK4nF+6
         8hZFtxDAunsX7XYrw8qCM5BniqmTpN3s/jW3IQL/uesDEm7RsZ1I66Mr3KMscX7/hVmO
         HfJVSlQJuTmxNrQFXcesl32UDhJKBRU3SkAODVOaIQOBfXW2/x/3AlwesqYWJ+DMTeDJ
         mzwLDUiL2T9UzhdDEIRWLhiAFNGbrHrKdfNLHMpu2/MhXIpucjjbh9eVcxTjquMZRFad
         NGHA==
X-Gm-Message-State: APjAAAV/vGbYYpRA/EHCXYERnGkqMIxqkcvB0fp1E+kaEp4Ujj4T5IfZ
        HDfdnX2qfb3J0+Q9pRYs68l0H3V6W1vI2gTbFCYHIw==
X-Google-Smtp-Source: APXvYqxFw0PixT6czuXw2KjQpezDgMGtxaaLVVUxBSilC7n3O/FSvVnHvBWJt563rU52HGEH6/IzU5WC0dCNqjLOXLM=
X-Received: by 2002:aed:2f01:: with SMTP id l1mr23183037qtd.391.1576486846418;
 Mon, 16 Dec 2019 01:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20191015065002.18701-1-drake@endlessm.com> <CADnq5_M4Leu0raYS6M72MqTm1+PLg9BjHCHLAYuB2-dEVP56_A@mail.gmail.com>
 <CAD8Lp443ZhPEo0PJRxbTSB9DY9x92OvWBeH29m9Ehpyhg+2n5A@mail.gmail.com>
 <CADnq5_OaATVESAY9E2mtd7PoV2VjG=WLS56LCHVpieSHDTas0A@mail.gmail.com> <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
In-Reply-To: <CAD8Lp46f9LR_VJ26BGfOGvj8sTjKZowkbjLNv6R4CsVMfRZQ=Q@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 16 Dec 2019 17:00:35 +0800
Message-ID: <CAD8Lp46+Te+AUQKLkLEcGf34izw=JzkU5w=CsZRf_UKJQ_k7qg@mail.gmail.com>
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

Hi Alex,

On Mon, Nov 25, 2019 at 1:17 PM Daniel Drake <drake@endlessm.com> wrote:
> Unfortunately not. The original issue still exists (dead gfx after
> resume from s2idle) and also when I trigger execution of the suspend
> or runtime suspend routines the power usage increases around 1.5W as
> before.
>
> Have you confirmed that amdgpu s2idle is working on platforms you have in hand?

Any further ideas here? Or any workarounds that you would consider?

This platform has been rather tricky but all of the other problems are
now solved:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f897e60a12f0b9146357780d317879bce2a877dc
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d21b8adbd475dba19ac2086d3306327b4a297418
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=406857f773b082bc88edfd24967facf4ed07ac85
https://patchwork.kernel.org/patch/11263477/

amdgpu is the only breakage left before Linux can be shipped on this
family of products.

Thanks
Daniel
