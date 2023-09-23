Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E4F7AC47F
	for <lists+linux-pm@lfdr.de>; Sat, 23 Sep 2023 20:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjIWSrA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Sep 2023 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIWSq7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Sep 2023 14:46:59 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B9136
        for <linux-pm@vger.kernel.org>; Sat, 23 Sep 2023 11:46:53 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59eb8ec5e20so47935447b3.3
        for <linux-pm@vger.kernel.org>; Sat, 23 Sep 2023 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695494812; x=1696099612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lp4rqH/fgRa84q4bZqMK+Guj4Ezv52nETpih6zUjHw=;
        b=g4VrMnolXzD3zZ/0E3hR5BnbLkuZjMaD1irOZCK12IoTEQj0MIAzyve9urHYgKOa7n
         N6rkJud2y3ByiVfC92uNHkx8QxZ/1ElbYVldJd93515TU4Dl5kSl09Q9pwtpXhAoutj9
         OEbxFT3Eakp7MR/vXLhmASurDX8SRWDYHcBbA+KtC7k7LNkBj2IcyjUmBqBDezUHFqsi
         WnoGzEzGzq6Enn56jx7Flx33DHyEGP7YvqRnAONHz4WWD0UVUk8S/MoSeeb3L0o5RRQz
         7bfnHFnPwbhJKCknOLN8IyH1iB/Jk+rTM3dmQeszmjH93xBgFJ9zyb82S3aPttejwtWi
         PwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695494812; x=1696099612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lp4rqH/fgRa84q4bZqMK+Guj4Ezv52nETpih6zUjHw=;
        b=BXh65fdaBokwrpFAKOnjm2/6ftBk0Z7fdjOFycLtm2Dc2qk3F3nRHg1kfTsygpDX7G
         4u01T7TFojE/iKrw9mR6kIF7CWHo6i9tOe9XXicis5yR7NJlvXM/HN/dZaLLYIytTDO+
         CIYFYW712EYxysttJlhw8gENnBXsdiEY5h9vOtxelaLhIOEEAah3KIHKKVumzDQr+pcA
         X+bwajvRLv0JvENPyvlqPWuf9mGME6wrTm5XDwuYest3x+HA6bS7HAfbkK32EQN3qwe+
         xi/WYr8II4Vq+N2DPVoE4437G+CDl1yfyzPHGmvB8mRTZ25VTDRpk3fof3G3JkD0udm1
         Mjjg==
X-Gm-Message-State: AOJu0YwPmCAv5oI1LuK5C16d57ln3qONhwZC7U1QHtcQiLe3CxG7+Bw0
        B26XJWaCUncmTxNvGsaU8wR1GKGCYmaokO9s7tcqLA==
X-Google-Smtp-Source: AGHT+IGqpLDQaSKpfRkGN4iCRx1ZP8Q1I74Bfq2VhneqyGobUNQ6P2RuDQc4LxTjxhw6/3msKE/hmUsc55+LyS5yHyU=
X-Received: by 2002:a05:690c:4483:b0:59f:5361:d18c with SMTP id
 gr3-20020a05690c448300b0059f5361d18cmr2072246ywb.41.1695494812564; Sat, 23
 Sep 2023 11:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com>
 <20230922115116.2748804-4-srichara@win-platform-upstream01.qualcomm.com>
In-Reply-To: <20230922115116.2748804-4-srichara@win-platform-upstream01.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 21:46:41 +0300
Message-ID: <CAA8EJprB2WgVGyDmeOCRrAiyZ4o0HtWmj+P8GTCyY6wNEKywSA@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] thermal/drivers/tsens: Add support for IPQ5018 tsens
To:     Sricharan R <srichara@win-platform-upstream01.qualcomm.com>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_srichara@quicinc.com
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

On Fri, 22 Sept 2023 at 14:51, Sricharan R
<srichara@win-platform-upstream01.qualcomm.com> wrote:
>
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>
> IPQ5018 has tsens IP V1.0, 4 sensors and 1 interrupt.
> The soc does not have a RPM, hence tsens has to be reset and
> enabled in the driver init. Adding the driver support for same.
>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Fixed Dmitry's comments for error checks in init_ipq5018
>
>  drivers/thermal/qcom/tsens-v1.c | 60 +++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |  3 ++
>  drivers/thermal/qcom/tsens.h    |  2 +-
>  3 files changed, 64 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
