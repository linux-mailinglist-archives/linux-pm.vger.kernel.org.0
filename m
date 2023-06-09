Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CDE728DDD
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jun 2023 04:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbjFIC0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 22:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbjFIC0F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 22:26:05 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F93E30FF
        for <linux-pm@vger.kernel.org>; Thu,  8 Jun 2023 19:25:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so1554257e87.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2023 19:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686277558; x=1688869558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx8vlVFOYPoBRf3/7QVPvJM9NkCsM7ZSm+3sIzim6r0=;
        b=OzqK4bRFx5xgl3jC8ZPEud/vcTiMIGNnjTfZW++y3Pk1VBMleSTBaL5YF+Mh5Kt4FO
         dJRNMA2bmp2uGj4Yk9y8lbUYFtjkGjaiLW6C+ms4v6uOK6Z2Kog7rr5XMb3WOZ7jGEGa
         UUSKq32plaQ/u7oSzfsLIWSLiaIlCyXukI+IOGENm2gwnZFO1LlPm6HfLzTclLM5oKRO
         Zc7Ih+ooLcz/YDewWz2kMJU9B8RMO/t0DW+XAppZFeyAfm1VjYitAx7lYAoJ+HgTjATb
         xchbPff2sQ3defShS51uJlGgrcShjiCa+8LcFK3iaaNLwj+OGsRUp1dSAXYCT9qi7UDY
         RRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686277558; x=1688869558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx8vlVFOYPoBRf3/7QVPvJM9NkCsM7ZSm+3sIzim6r0=;
        b=C+1EM3dNxkFKxRRgLINt8maQIULMz/CgG463xl6cZDUrTara0y7NOm1GiWqmoZMLxZ
         zpEoFxmyBgS0MTKB/8j/l+H9e8Z/qwCdaXhGBwy/VtoPHBJ8wl1rlUWVF9V1Gj/7YeEe
         40uX1gnNA4aAkFwIJNt+PTG5QE2GYUvqvXzRMkxS1ACMtTmLzidiVAIzEt4a3d8w7zo4
         tLvQa8BPNYVG3l0R3glrLIbTMGAuGe3mGDS+NUfrlTgIwtLsI7aUx/5B9t4c8nz40t4Z
         HvmgDM8joUWBzRoTBTYCqaP0idSqyaLjLrT78W+m0s5eRhAxkHpvq6Bn59a4TGKP77xT
         qqFQ==
X-Gm-Message-State: AC+VfDyOxMoBxGNXE+tmhXTlNiVB2anGXK3QE5Px2csg8ven98bfceMS
        XE5soW0FQR6GBiCfiD60v1BFuA==
X-Google-Smtp-Source: ACHHUZ6zikMFOOH6trhKWp1UILouE9b5IDWqCaPz1YHNv44N5d0uokEFyYvyPU0adE/+LDhw5QX+/g==
X-Received: by 2002:a05:651c:20c:b0:2b1:fdcc:14e7 with SMTP id y12-20020a05651c020c00b002b1fdcc14e7mr130689ljn.35.1686277557845;
        Thu, 08 Jun 2023 19:25:57 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e9dd4000000b002b21089f747sm167429ljj.89.2023.06.08.19.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 19:25:57 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 4/4] ARM: dts: qcom: apq8074-dragonboard: add resin
Date:   Fri,  9 Jun 2023 05:25:53 +0300
Message-Id: <20230609022553.1775844-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609022553.1775844-1-dmitry.baryshkov@linaro.org>
References: <20230609022553.1775844-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add device nodes for resin (reset, volume-down) device node.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 72f7e09a5bbf..34258cf84a23 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -90,6 +90,11 @@ &mdss {
 	status = "okay";
 };
 
+&pm8941_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &pm8941_wled {
 	qcom,cs-out;
 	qcom,switching-freq = <3200>;
-- 
2.39.2

