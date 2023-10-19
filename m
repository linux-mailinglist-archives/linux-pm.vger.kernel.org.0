Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01C77CFDC2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbjJSPZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346278AbjJSPZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 11:25:01 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF52121
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 08:24:59 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a82f176860so77842127b3.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697729098; x=1698333898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J36Azv4uFKfg/u6mhROMjBfFW8n3utMKNNnMSljqYeE=;
        b=VGveyvSvsLKS++qcGlCJY8A1pPq1gp7P3srPDzA18+MJK0rG0BCN21A6x5Tzy16lkU
         7EH6I5h2SvXa1gd9zwkF0ednBzal4bCTSHwVoV1CRmeyKLWDR2XlUB0a6AfMcHyfyR5R
         +qqrZhUHl8DmVQtPFvvfTDumVzsB1RM6f1E44o6CTrmPSzLt0rna837cqBjrGCtXip8j
         qyOGTqsHSZ0rvBy2HgmZl6GVq8ULfsJIZXClOZ7A0wykBS+LBrTOV9QVb/Qsp6Eq0YIU
         xDlBbRAwQdTbdiSIgMGb8OMJMU4gDjLHBDnNukqXcSpKM4NgPkJzx8MlT6fhze7wSPRf
         XR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729098; x=1698333898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J36Azv4uFKfg/u6mhROMjBfFW8n3utMKNNnMSljqYeE=;
        b=ELZxBRvmVq2hJaEdLsuKvR9JT2K9HGQXQCgf1X2auANeAcU4kCK25TSYM5rCj1rafN
         fMtgX98+0N4xTS7Fer7F+7fF5SdgcFx1YaneYa+V1UFqK0PBXkx6Q7MpcOLo572zVy7K
         eEk1wHPHpulQq1388rkwH6QR4RMjo/dPAjXmQVt8QfTAcI+GLCg1kYbvE38jecdXSRad
         tf7/kaSLDgGw6WnKiNlTPpWjRY0hxZan++nRV0aiYUtr2SfCYe+iyulQ1x/liQPWkvgV
         tibAU0WwuV1pr7UAhc3pe4eFYuZy4smCA3G0vwR3/Rv7BceOjcD0lT9XXs2y8XcdT6KJ
         jOEA==
X-Gm-Message-State: AOJu0YxbsrnwWEFlcNkHuEa5ryGplhqzYBVfzhPZ4uTNNQkKCeG2zhjg
        hFheHKTRirSoMbhuDiUN9KuPdZ2JGCRveGgk/jFKsg==
X-Google-Smtp-Source: AGHT+IHoS3lOcMrgJgOvXlMdvEHQhDGEb0EgVhhsMBQfKYrpGUPWK2pq2iY+oQNE+Hf0v59dLYODm4po1Lsi9OCNyeU=
X-Received: by 2002:a05:690c:dc4:b0:5a7:aa54:42b1 with SMTP id
 db4-20020a05690c0dc400b005a7aa5442b1mr3552884ywb.28.1697729098464; Thu, 19
 Oct 2023 08:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231019144311.1035181-1-dmitry.baryshkov@linaro.org> <ZTFEVpNOkGedJGoj@gerhold.net>
In-Reply-To: <ZTFEVpNOkGedJGoj@gerhold.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 Oct 2023 18:24:47 +0300
Message-ID: <CAA8EJpruauNB6c7O1p3fRJRLPmL7bH=PoSffJiBoWn=pSOwryQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/qcom/tsens: drop ops_v0_1
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Oct 2023 at 17:59, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Thu, Oct 19, 2023 at 05:43:11PM +0300, Dmitry Baryshkov wrote:
> > Since the commit 6812d1dfbca9 ("thermal/drivers/qcom/tsens-v0_1: Fix
> > mdm9607 slope values") the default v0.1 implementation of tsens options
> > is unused by the driver. Drop it now to stop compiler complaining about
> > the unused static const. If the need for the default v0.1 ops struct
> > arives, this commit can be easily reverted without further
> > considerations.
> >
> > Fixes: 6812d1dfbca9 ("thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Seems like I remember correctly that there was a patch for this already
> that wasn't picked up yet(?):
> https://lore.kernel.org/linux-arm-msm/20230617113837.3224912-1-trix@redhat.com/
>
> It doesn't have the Fixes tag though. I think both patches are fine.
> Thanks for fixing this. :-)

I'm perfectly fine with either of the patches being picked up.

>

-- 
With best wishes
Dmitry
