Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961F23A509C
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jun 2021 22:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFLUz5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Jun 2021 16:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFLUzy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Jun 2021 16:55:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC55C061574
        for <linux-pm@vger.kernel.org>; Sat, 12 Jun 2021 13:53:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g20so9902851ejt.0
        for <linux-pm@vger.kernel.org>; Sat, 12 Jun 2021 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XiiHomSDQ1o4VUI3T8udjQjFfOxoZmojvalr/eLfj2o=;
        b=HgVRp6IL+BYfu9aHLffjfvl5GNbB5ZX9YsR+62rCSA+crSI0+5oWYT9uOY4Q+A4OH3
         s5ty40rJUCrFYkG+3eruX3N+b7SJoxZPDTkYGE1fmEIMc7QmVm56nuuBsg8BtPvFK6jJ
         uYox0TgiXNq7uJUbSO6zJfV5iS0nHWwH8rLciSJ59IQRxyXlDwMao0jMWISHQe3dK0Qz
         +i/WT8BvaCwUHFwZb1O/JjEqDmjx3gVKCwtDPqFCiWqv13tSeqLgr+uLIvyCBaejFAwf
         dwRsfkm+Fce71k7lKbgxU/1KWOUFm9ZDHmvmrC2eKY3nl5uYu1vuvceZXhsIKGipG9oQ
         l/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XiiHomSDQ1o4VUI3T8udjQjFfOxoZmojvalr/eLfj2o=;
        b=FsGKPawj7bxxfV/OU856lM98RKPQIdsbOhsa6iYnUVkltAVz43T6NxXkk27NybIcgg
         Q6y8prXD3/VG04cuPR1ofdvgaGXE7AIMzDSmrLWb5+sGMqOf/7GrnItrE1slmnEhfZ4E
         HLl+gBfx5+HzC3Z7t+Pi5FeK57msr2bxKQ5Ao8aUqovPmePw6gyyJsRbSBbsL8gutB4x
         SgmFXQ7UwG99yEuY9BRKI51mmSl2gcJb83/hQBH80WObaRIIQybdbIdX6A2Kw5PvSxWG
         X3h17Cv3YD0IfqiyqnCiPSgWb93+AcTeZz6AVrBWo2SDibTxf0zIto4Ocj0mmRZ0gD/s
         lyGg==
X-Gm-Message-State: AOAM531CZAPixqr48zE4Rl5hbQrziX/KfQaxxnVQXPRDRriDsYoYLHB1
        5JWo98YJKlY5yDmZR/30584nvg==
X-Google-Smtp-Source: ABdhPJz0ryjoTQreGfAJzewZlYlepEh5I7//2yewTSPYlLViSpawJAIQC5Wm+lAhXNZaevQvsnggbQ==
X-Received: by 2002:a17:906:ce4a:: with SMTP id se10mr9354594ejb.235.1623531233345;
        Sat, 12 Jun 2021 13:53:53 -0700 (PDT)
Received: from PackardBell (192038129059.mbb.telenor.dk. [192.38.129.59])
        by smtp.googlemail.com with ESMTPSA id a2sm3574362ejp.1.2021.06.12.13.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 13:53:52 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 24c9afc8;
        Sat, 12 Jun 2021 20:53:45 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v2 1/2] dt-bindings: arm: msm: Add SAW2 for MSM8226
Date:   Sat, 12 Jun 2021 22:53:34 +0200
Message-Id: <20210612205335.9730-2-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210612205335.9730-1-bartosz.dudziak@snejp.pl>
References: <20210612205335.9730-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the dt-binding compatible in the SPM AVS Wrapper 2 (SAW2) for the
MSM8226 SoC platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index ae4afc6dcf..94d50a949b 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -25,6 +25,7 @@ PROPERTIES
 			"qcom,saw2"
 		    A more specific value could be one of:
 			"qcom,apq8064-saw2-v1.1-cpu"
+			"qcom,msm8226-saw2-v2.1-cpu"
 			"qcom,msm8974-saw2-v2.1-cpu"
 			"qcom,apq8084-saw2-v2.1-cpu"
 
-- 
2.25.1

