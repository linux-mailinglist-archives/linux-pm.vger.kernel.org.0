Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1124EFD11
	for <lists+linux-pm@lfdr.de>; Sat,  2 Apr 2022 01:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353184AbiDAX01 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Apr 2022 19:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiDAX00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2022 19:26:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD4A6579D;
        Fri,  1 Apr 2022 16:24:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q142so1709152pgq.9;
        Fri, 01 Apr 2022 16:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qw1VtOJVK96ToOzSzjlnaE5teuYd/QDuV0K0QqZa/bY=;
        b=O5q1kx0MRLqY2BVj4+j+eIthVn+OuoDgWOknFPwmHmtqpm/Tob9kAyqvOXLJoI9DcT
         oCqv/XyCymE00tA04a2nAZ0E06nXqqZJpafUFRFABJRW2FODMs1uI3tuVuCWVEjILJOr
         B2JRZ9n5gTqpCga/JegOZaKaWFZ3mX9gGe4nu0K8i6P+Iv8vx21rbGBjY/lufkc19Jrt
         i3GN3N85vxPqspXy1agY4SFOBNKgmdVdFINfcxiYsJ2vNGYfs9KkLNxTiFqTGQigCSUZ
         3P1zZ4Wvobu64Gg9HgvvhMD7uFRmNmTeJljnjyr9ZFyzRu8nXLQXCqLOklTwDjM+DY5g
         mM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qw1VtOJVK96ToOzSzjlnaE5teuYd/QDuV0K0QqZa/bY=;
        b=owFCdA9qR760drIKS767Dy78F8gAVEiWmzGk9T2n2Mk6xKaICWYFC10UPfVFHSccPU
         24sxY6aAOXK+ZgVJiWwB2dDO6mGo9kjOcX2f1IDzLHkf4rRsTpfR2RstqDtk2uxyIrUR
         uBXauhvyhn8Shbwly9+d/3TmKa1dEGrq3XMRwLnB8KTGrD5pkya0HYoQuyCFGWOLyNyV
         hPZbYHjA9UhfGk2uh9TxhVD6CCaY0ho9GaPJsaWH+1duUMMbdqsuwqhlwybp10+9z3Eu
         5fSpTIx2a9WK3wmYdf8A3sPs3x9jenp4sw00Eg0LsPk1l8VT67p4L9sZc6hFw/KaFQvv
         Q6mw==
X-Gm-Message-State: AOAM533TfJ/I7tUqdBWUpVYzKPMSK+g5W2s2PHrMi/j8zPjV8z2Np53y
        8jKMPwtwetq+rseTEegZ5OjujP8X3nA=
X-Google-Smtp-Source: ABdhPJyH33MBgDtn1fAI/YTEAB+deVUk5lTQr0H/hzjU0VkFQFXto1diYSzOJdMRWlXg5dnw2EpsoA==
X-Received: by 2002:a05:6a00:24cd:b0:4fd:9038:8aa4 with SMTP id d13-20020a056a0024cd00b004fd90388aa4mr20145650pfv.78.1648855476255;
        Fri, 01 Apr 2022 16:24:36 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id lx13-20020a17090b4b0d00b001c9989c721esm15056241pjb.17.2022.04.01.16.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 16:24:35 -0700 (PDT)
Message-ID: <fa03e4ea-774a-b7a5-71f1-9ed3b576b00a@gmail.com>
Date:   Sat, 2 Apr 2022 08:24:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -pm] docs: driver-api/thermal/intel_dptf: Include
 isonum.txt
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <e06542af-aa8b-0885-37a3-bb7bc5fafa1e@gmail.com>
 <87y20oyigv.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87y20oyigv.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 01 Apr 2022 08:41:04 -0600,
Jonathan Corbet wrote:
[...]
> Interesting...I don't think that was always necessary.
>=20
> I have to ask, though: is this worth it?  It adds up to a fair amount o=
f
> clutter to get one symbol - =C2=A9 - that can also just be inserted dir=
ectly
> if we really think we need it.

Good point.  The motto here is "Be nice to readers of .rst files".
Just sent out a v2.

>                                 I'd vote for doing a global s/|copy|/=C2=
=A9/
> instead.

I leave those cleanups to someone who can spare one's energy
and time.

        Thanks, Akira

>=20
> Thanks,
>=20
> jon
