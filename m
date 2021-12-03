Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6DF466EF9
	for <lists+linux-pm@lfdr.de>; Fri,  3 Dec 2021 02:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhLCBLu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 20:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhLCBLt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 20:11:49 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E594C061757
        for <linux-pm@vger.kernel.org>; Thu,  2 Dec 2021 17:08:26 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id gu12so1275113qvb.6
        for <linux-pm@vger.kernel.org>; Thu, 02 Dec 2021 17:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPKUxsZ6IaUG10a4mQx/Ajtc5nLWYraUFCqu8NpUt0E=;
        b=MYNA9pJhs096o+/3y9KNFMGK6bMN8q34SlTOaaa8ODXJIGaIm9Vz064wclZwzZ8ZV5
         2/xvV6/QFY2dqB1oDXvPn7Bnrxm82rVQjMYg53hukhmZlOUiePZaRFfa/zLLLOJ/Eiw5
         g7VgE0s/qV5ndemPjxFv40ivn3Cx+unbyebhh+gTO+beKp9nJmJeXMfTXh1EMdwjX4i9
         E9X9I4b8qmBkj5W3yDmRxIBQe8rLMS6h/z6XZqbLJLXBcRVQEthwhJVjnGXcQrtrUs/V
         jh4hUHZAEAa/vR4fSOu7BLucRs3BpPrSIu657QTG2oxJ1hWpfW2FN0gI9D1b0meoFTGO
         eXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPKUxsZ6IaUG10a4mQx/Ajtc5nLWYraUFCqu8NpUt0E=;
        b=ISwaJXENey3TSxJom0SoAnJThsNP8PknRV4XeP+B79EFvhwB1eOXf1FLr/tNWhExXG
         jUcoRKm12cr2HcUAVFbBZ8z/LcMUmnuTRGucEW/KHiui79Thl6KqrDa3PonMPMEsQOTz
         O0L00x54/s+Id4hDEoiY2PDcJfLPoN4Zw9puhi60iQ9zceoSVsBfy8slWrVvxkrbUYEU
         bZChVF6uYPw/b5jAyGS1iw/8WuzJAMwaPMGntAPGjhKtxbxYtqadIGsQA3xBj9ffuoID
         C5uIMS+GiCSNx39b5tcrwOOkBzlJvi1O9FHzbbbntAoxBMKJOcJGT62La5hDDX/O0ygz
         Yi5w==
X-Gm-Message-State: AOAM531ZW+WUnWexhPDDFc2EMJLwfmuwW2kub/Kl9BQvnGLrbREJctpm
        iswYNatPgnHtoS4Mu/wx7cPsX4OxsiXdCp/Dl7vvmGEYCjY=
X-Google-Smtp-Source: ABdhPJxBuNgJi00NEV4uwY2YXzEFZyyq/AddAmN7r5+588FiT32RnS0i5eaQsuJS45BRQg2lcOe9Nsu/73+p99cPVuk=
X-Received: by 2002:a05:6214:1513:: with SMTP id e19mr16872895qvy.124.1638493705407;
 Thu, 02 Dec 2021 17:08:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHbf0-GPqod-W5exGt4c63YYVG27M4qdSi25wwqmFfC_ypTFyw@mail.gmail.com>
 <YZzRW3pjIoJ4k4O4@hr-amd> <CAHbf0-HnJzS7+DaX5o2v4bruVRgpSynDeUvSBhrZnn0NYGkRRw@mail.gmail.com>
 <YZ22dYQ8dgQTwqnh@amd.com> <CAHbf0-FnFpkmZ2bkfS2S=Cw_RLbK1y7eSHySAFGVecs+t+-aVg@mail.gmail.com>
 <CAHbf0-F2v_tziWORHFkAOBS0oRK15XcPZpTkDbxsOp4ibTX+wQ@mail.gmail.com>
 <DM4PR12MB513676A292976E478227E133F1639@DM4PR12MB5136.namprd12.prod.outlook.com>
 <CAHbf0-G7LEUuEtsh7XsK0Nv4xcKJQQbV9DAzUxxeJUvkhky9JA@mail.gmail.com>
 <YaYB6UoC1iqsNuJL@amd.com> <CAHbf0-EWVeD8xehHZc8ff-4vYbXC69z=kMf0_=RXJsHKG_2M7Q@mail.gmail.com>
 <YacbY0XD+p6d70Mj@amd.com>
In-Reply-To: <YacbY0XD+p6d70Mj@amd.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Fri, 3 Dec 2021 01:08:14 +0000
Message-ID: <CAHbf0-HBag=RBi_=FJ==0CGxsF456y3M13EvhtGpsuxc=+AtEQ@mail.gmail.com>
Subject: Re: AMD Pstate
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 1 Dec 2021 at 06:51, Huang Rui <ray.huang@amd.com> wrote:
>
> On Wed, Dec 01, 2021 at 01:40:52PM +0800, Mike Lothian wrote:
> >    I've just tested v5 of the patchset, the warnings are gone, kconfig
> >    looks good and shedutil seems to be behaving
> >    Would it still be useful to get the above trace?
>
> Is the previous issue that the cpu clock stuck on 1 GHz still existed on
> V5?
>
> Thanks,
> Ray
>

 Hi

No the issue appears to be resolved, schedutil is now going to the
maximum frequency - it appears to be behaving now

Thanks
