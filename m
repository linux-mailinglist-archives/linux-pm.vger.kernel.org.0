Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6CC569814
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jul 2022 04:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiGGCbx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 22:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiGGCbr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 22:31:47 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD12F3B5
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 19:31:46 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-fe023ab520so23650212fac.10
        for <linux-pm@vger.kernel.org>; Wed, 06 Jul 2022 19:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+CDqhKLFSdtFr+4g/PZBOEODsX3smaY09cPDWxItrA=;
        b=vo/r//BX0sk3/UBS3biicwB6Wg7z1c0sTfukn+Tvej/oe3UyWH1dwEwvKc+Qd4GqbJ
         PhGKj/4xw+emWIYPX98awkGZPQSm0ZD0s0VHgK87Kaed/qNbDedl4WHnJz4FG2WdJCdi
         GrInId4Am1+eU+o65gYVCzQqk/04Sde2vp9xlM/NgIW+CM8Ud0j2SQSKTzGOxrwR2d8C
         pRNRvs6OLEKTTIMc5xDTIXhO65Pf2oNqVMS72alCNRhCZfAgYlER4axKfQD6A51zFm8Q
         fUOcgcaHzjiK2Q+fKmOXXdViPS4ah3CxPSo1ynqhkAivB87RH8mmfNZ5ZvPeNGw4N2By
         q9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+CDqhKLFSdtFr+4g/PZBOEODsX3smaY09cPDWxItrA=;
        b=xu3esF/cH3KT+t7xrApWmGLOlyNO0VnYxbwUSm+A9nbLadXZE7DeNtfSPhr+DJLXu9
         hHlvJRjDGs3gIyt2cgzbfr3V7LBLHsaWvP/B2timgdsJfZXCROlN3ETbtLZyysknWOCw
         klP7OlNG0RdHw4BTsR9V5A/IbLmetvk+eL3ieDki0HfqHXfOu7pmiETlBwn6xVaqSlR2
         65z60vuVrJFLoZa2gFdvC8oAGcDXkRHPYNiMwyTAhK8TO8TLYioNxnXYaASyFX5wborz
         u32oh8EBYwaOzIifPaytrvF8ByXPcnVyQx7bDH/HekMXfsLwu6kzF7cFrKRnwvllpTKg
         IX6w==
X-Gm-Message-State: AJIora96hs9m8dS3A1+NyKI2c6XZq6RHvS3dPNLJKH6ZXwlXJhTGSTPV
        VbjfqOK1WcGn4cN59qF5SzdDSg==
X-Google-Smtp-Source: AGRyM1srEzppwLSuc5r8vVwc7RKHk5pNVB4/DqYy5ouSZJhxbsqWGuU/TB7adm7VYdcT8RTlwxsfMA==
X-Received: by 2002:a05:6870:f693:b0:101:cb61:2937 with SMTP id el19-20020a056870f69300b00101cb612937mr1217008oab.151.1657161106276;
        Wed, 06 Jul 2022 19:31:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x48-20020a056830247000b006168c71ca4asm17024469otr.56.2022.07.06.19.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:31:45 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH RESEND v5 5/5] arm64: dts: qcom: msm8996: Add interconnect support
Date:   Wed,  6 Jul 2022 21:31:23 -0500
Message-Id: <165716107313.864223.6512259211195719979.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211021132329.234942-6-y.oudjana@protonmail.com>
References: <20211021132329.234942-1-y.oudjana@protonmail.com> <20211021132329.234942-6-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Oct 2021 13:25:23 +0000, Yassine Oudjana wrote:
> Add interconnect providers for the multiple NoCs available on the platform,
> and assign interconnects used by some blocks.
> 
> 

Applied, thanks!

[5/5] arm64: dts: qcom: msm8996: Add interconnect support
      commit: f35aaef152d16caa9e27656c51e95b20f7af5514

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
