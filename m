Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6741C7CA1BA
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjJPIgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Oct 2023 04:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjJPIgZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2023 04:36:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4DDC
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 01:36:22 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7dd65052aso57840387b3.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2023 01:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697445382; x=1698050182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1SNXuPtXmj2fQhIm8tBTBQEwsvs+opJi/YXGoSztt8Y=;
        b=T9D9kr0f+2FXem6bD3eSa44HeqQ81qANoc56XspO+W0WgbGzUfheTpsuQe9aWhhKFf
         yXn/B6h+jevy0b73hvDZHPXIxR8/xP94hmSlit+BiRJzI7zROI9yoV2ElHJ7i2UUtsaU
         5fvxhRHQXocRweeyvqofHbnECs0F/H3/7yzRyA/8MziFccEUDlEWwx7cJtzEyN8eniGD
         a9y1k80Kat+CuMZgcFbLkSQo8CGpZyuk3v/9znFw82oILgfIrVn4zmHjmMO37OeGvss+
         aycrzDEYLZf6Rav0sTJp4hJiJTgqkFS2bc3Cu+EZ6J4ueYRRWPK03QhL8wJkwAsQsPry
         YGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445382; x=1698050182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SNXuPtXmj2fQhIm8tBTBQEwsvs+opJi/YXGoSztt8Y=;
        b=Z3AwqRS+mkC3tow5K5tZk7M3sYIaasK2omLHMmwYkYjZtdbC4jSm7m0OBVg6cNO4+A
         HsJPTLdZ/MUC0jwltX0my6WS4ElNF268UP4YK+BJOStMVShwX2BeYkgDI9sWh/qv47Db
         8Zm+F+j93kM7EUekOaaxtM2ukQ4IAZPA/8zMuKloc/GRc3ArpctmXAPQYvbME8tDNbg+
         hXEfyN52I7O3JE6KIvbSGKqJYUfvkMuqvc8hq6zg0ClBwZTjDHZZuKw/NyZ8NrLUen7w
         XTw4nDMJ1PWhw8VOyz/sQo/NueLNj8IO4YtYssHSpGAiSs5Vl9EcXbVyvuc68vD7HkX/
         MRcw==
X-Gm-Message-State: AOJu0YwX6Sc1I9lsIF/fazk1D7eXDX39DDTCXwQ0/MQSdGwsZuX3+dcn
        aKpI8azlVT7CuGtL8KGuZNqzalHsgYe2llD73wv7cw==
X-Google-Smtp-Source: AGHT+IEDZvq5LygdbvPDaDHVToGBhCCiH89o8jCHP9mqyyFSUNZ+z31XsBZ+TIqdWPH7ijreVN1p/lMAyZpe0otVnDY=
X-Received: by 2002:a0d:f245:0:b0:595:89b0:6b41 with SMTP id
 b66-20020a0df245000000b0059589b06b41mr33060293ywf.38.1697445381785; Mon, 16
 Oct 2023 01:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231013172033.3549476-1-robimarko@gmail.com> <20231016033202.i54nequofzea6mfd@vireshk-i7>
 <20231016082239.2onlrqp4bpcgxhbt@vireshk-i7> <CAOX2RU5paPXyG-1Fbp+T9+Aycwno9DQ8ugMwUr_8iNhhc3HiHA@mail.gmail.com>
In-Reply-To: <CAOX2RU5paPXyG-1Fbp+T9+Aycwno9DQ8ugMwUr_8iNhhc3HiHA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 16 Oct 2023 11:36:10 +0300
Message-ID: <CAA8EJpq9=dtemYLCeL8=+q1x_i8Gp2duMSAo90ZttgaejBXCdg@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: qcom-nvmem: add support for IPQ8074
To:     Robert Marko <robimarko@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, rafael@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Oct 2023 at 11:29, Robert Marko <robimarko@gmail.com> wrote:
>
> On Mon, 16 Oct 2023 at 10:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 16-10-23, 09:02, Viresh Kumar wrote:
> > > On 13-10-23, 19:20, Robert Marko wrote:
> > > > IPQ8074 comes in 3 families:
> > > > * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> > > > * IPQ8172/IPQ8173/IPQ8174 (Oak) up to 1.4GHz
> > > > * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> > > >
> > > > So, in order to be able to share one OPP table lets add support for IPQ8074
> > > > family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> > > >
> > > > IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> > > > will get created by NVMEM CPUFreq driver.
> > > >
> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > ---
> > > > Changes in v6:
> > > > * Split IPQ8074 from the IPQ8064 as IPQ8064 has additional dependencies.
> > >
> > > Applied. Thanks.
> >
> > And it failed to build, please fix it. Dropped from my tree now.
>
> I am looking at the error and it should not happen as the ID-s have
> been in linux-next for a month now:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/dt-bindings/arm/qcom,ids.h?h=next-20231016&id=b8c889bef9797a58b8b5aad23875cc4d04b3efd3
>
> They are also part of Bjorns 6.7 driver PR:
> https://lore.kernel.org/all/20231015204014.855672-1-andersson@kernel.org/T/

But Bjorn's tree isn't a part of the cpufreq tree. In such cases it is
typical to ask first maintainer to create an immutable branch / tag,
which can later be also merged into another tree without going into
troubles of merging the whole tree of the irrelevant subsystem.


-- 
With best wishes
Dmitry
