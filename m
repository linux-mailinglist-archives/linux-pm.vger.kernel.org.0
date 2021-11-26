Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5351C45ECA5
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 12:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbhKZLd1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 06:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbhKZLb0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 06:31:26 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACB4C061D70
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 02:50:19 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id v2so6820373qve.11
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 02:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTj0RgMZn9y+U/UV9eqqhWsTyHgg5vVZPZwBgLlCeQQ=;
        b=MkTBNkxzE94YqDnk5rV2GhOpv/Q8YZbJDt+962gKaVBxSxH971aeV4zkGUjh2x74iP
         LZ90eWkA6M0XtWPeBFIxFz0voWYnJQX+M5GYCAIQnazJ36KurT3xn+Ij3Vdm0dpXfKeL
         1r6aPob9lyMGejsjBeTxzeg1OFoR714AHO1isr52+ZQ/7iDUa6DeWIBBvQRk9rMnbwpP
         YMv/X77kiMZpBo7YrF3BSaYGtDLml14UohpILGVdnJo0qdHzdhJ8Tpd6Vg9fvS63MsFN
         2o/DHEPzYdfOqJRS41MYizMAnNImCd6G0ItVix7r7DkBIVgx7JHWK45QbijG8o+zM7sb
         8/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTj0RgMZn9y+U/UV9eqqhWsTyHgg5vVZPZwBgLlCeQQ=;
        b=73qb6FT3/ZToqosscKaahydNFzPOMI9hiqi4RNuB5X7GLjQCJIAy3Oy9VFhFG58mL1
         DzLOPoiv67WB1lGheNpY/1u2Fjalh5PoCsQzfuGWz+TXf6Ymj5a1PTClYLprCrrmNEuQ
         eK8KP/QcaHgnQAkamR/pnlXx7aljdlG9d71IkU2TLpZUySx7COOmsg8cqKsC7IYPef59
         zUIdaapqrz/V0qQeoErppjtLfOMi+FIYtba2b4snxRGl2Q6u1oRTc/FUmfrRIvLz3re0
         FdNkEfktvVtXDYNDJ5SIxpsIjo2WH+C0OpYP2uEDwfoOK1trPfIMuHvUHB2aaaFSOwAC
         64Dw==
X-Gm-Message-State: AOAM5327BJB7AkEalp9oXjbxHSgHfYHk5BMAxoFMBTxRJ4gtLonvro6J
        KuwY443D6j3qc+Px0uIlznnJlDF8a9igY1WyjtrOL+v55mE=
X-Google-Smtp-Source: ABdhPJybIJlgDAnaCYF0rFTU3zZSexHNhGnPG+Wvde10sf+DY4yleoObPJ8bVrQT05AyGBygxd2aQzMfIL4Jsjg4wJo=
X-Received: by 2002:a05:6214:1d05:: with SMTP id e5mr23623545qvd.3.1637923818394;
 Fri, 26 Nov 2021 02:50:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
 <CAHbf0-E5Zrs9-bWYMm8A-RQ7xd0DOCZopzZ2GjtH8xcFf4wVtA@mail.gmail.com>
 <YZzN4Nc2tcclbVIO@hr-amd> <CAHbf0-GPqod-W5exGt4c63YYVG27M4qdSi25wwqmFfC_ypTFyw@mail.gmail.com>
 <YZzRW3pjIoJ4k4O4@hr-amd> <CAHbf0-HnJzS7+DaX5o2v4bruVRgpSynDeUvSBhrZnn0NYGkRRw@mail.gmail.com>
 <YZ22dYQ8dgQTwqnh@amd.com> <CAHbf0-FnFpkmZ2bkfS2S=Cw_RLbK1y7eSHySAFGVecs+t+-aVg@mail.gmail.com>
In-Reply-To: <CAHbf0-FnFpkmZ2bkfS2S=Cw_RLbK1y7eSHySAFGVecs+t+-aVg@mail.gmail.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Fri, 26 Nov 2021 10:50:07 +0000
Message-ID: <CAHbf0-F2v_tziWORHFkAOBS0oRK15XcPZpTkDbxsOp4ibTX+wQ@mail.gmail.com>
Subject: Re: AMD Pstate
To:     Huang Rui <ray.huang@amd.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Is there any extra info that might be useful to debug this?
