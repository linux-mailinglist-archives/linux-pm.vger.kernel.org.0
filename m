Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F717C54E7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjJKNJP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 09:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjJKNJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 09:09:12 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78257BA
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 06:09:10 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7ad24b3aaso31392867b3.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697029749; x=1697634549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yiWRUyEiDpWCGNyAPRXmmc17YAfusk8TYErSchfY5T8=;
        b=wv6BDwUziErC+8cGvaZ5WKLoRcKg2zkn0LS4GeO55//cX/2apZF80pdk20FXo9nuUs
         +TCRcJ0g1uSBFyN6HuoXRvSCM2MsIlihsuItVxRJwZDlkbzRNcG0qCDzJfSA4JTbCvEc
         ecXFsp3eGWN0uRKoi8xc+9MGjUh2VEiWLDECZkJ72PVY0WKyL5ZtMQf4zO4ym/3BfpjL
         J9Q/b7/fHRwlXQyrT5hMTpG6KDQ/Etd5Mc4Lk3gdHg8rEqQS/kgKb1ej43lI1xRL1K5l
         HfDqzOfyX4GGOsjZ19HTpuV56oGnFCGVHfD4ViJc2/DeDp5oC/MVYqa2q7QJ3K+2XDyA
         W3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029749; x=1697634549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiWRUyEiDpWCGNyAPRXmmc17YAfusk8TYErSchfY5T8=;
        b=faMi8FuuFWVdxmklo8+FFpBBhWXw4Pdv0RI014Mkowr45As6dqJ5J2X/mnkIeC9VSq
         5Y/9P3C9ovnHb5rR1f5HFeOz091OBfGChy4bX9+HMqHOtAZlXRzrdTL19OKt5WxerMco
         dC+1ESVQ5RSyihboEL2F0/3uXNtyx4IYbg0+bshodlG5TuZyu2/GugULmpoZSJsEF4CK
         FU0VkyAOFuNS21xtGd04eKzhzx3escCeHc+ClZ/2W7Ru5uKcx55lYu9Ls2jdYKMcq8/E
         TLP6A+oyY0DnDQ0Xr8dk9vn9MSzUcrI2AeCh94ZucBbKBUezU67U3d8yYmTan3vS5gWA
         1pDQ==
X-Gm-Message-State: AOJu0YyO3DWvQfUU2VWfMATymnA/n5UU3ENrVdhliZQIian8dtDnhnUF
        8vQ/hbO3ErrCoCC27cNoEju7u2NqxCEPI5fED2sMJA==
X-Google-Smtp-Source: AGHT+IHPeYGW++8x+sjpixD4qx2spNUFG0w29RwTYjN1/EfQS3maABvYM9h8FieFcy0MebMY2EQIXWY+wRKbOMFmN2s=
X-Received: by 2002:a05:690c:fc8:b0:5a7:ed69:120 with SMTP id
 dg8-20020a05690c0fc800b005a7ed690120mr943754ywb.6.1697029749566; Wed, 11 Oct
 2023 06:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231011122543.11922-1-manivannan.sadhasivam@linaro.org> <20231011122543.11922-6-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20231011122543.11922-6-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 11 Oct 2023 16:08:58 +0300
Message-ID: <CAA8EJpoKPq2sVcudb84YRDGUtDtS3YMhNPejNeOtSr_7uU84qA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 11 Oct 2023 at 15:27, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> UFS host controller, when scaling gears, should choose appropriate
> performance state of RPMh power domain controller along with clock
> frequency. So let's add the OPP table support to specify both clock
> frequency and RPMh performance states replacing the old "freq-table-hz"
> property.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 39 +++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 9 deletions(-)

-- 
With best wishes
Dmitry
