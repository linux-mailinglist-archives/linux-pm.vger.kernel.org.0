Return-Path: <linux-pm+bounces-1611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D516E81EFB6
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 16:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560DB1F2179F
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2DD45956;
	Wed, 27 Dec 2023 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnDMjclf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409945957
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26fbc3b9f2so202425866b.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703690337; x=1704295137; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLqxqDFp3g+3ctBYsDTo10ZcgpJFg083E8N42zGHui8=;
        b=cnDMjclfrAtGi/lioxq7wyTONEk9+6IkpcRrhimtTkpBi+c0wJ/gtqGG+RBT6aQah8
         husp6Z5F8Y9vpRk9VSI1EbrETCCl/6ybnxRN8YBj29s/p974UDJH/jo5/XPN0mP1BEbP
         zHBU3CuFdzyV/6PGyCjGueOmqo/5ZwKbtopjV+7/jzCPTaIh18TPI5gb/LyodqkEnK87
         pM1/3gqm5y1FbUS1eF6rh3jSUIByKksvb7m5TZ6+0ix6Ye+i9jx2ArhXH7CYAr5MnKfE
         jBJ9KnXiADQzzfqh6LAEl3XxswIu9n3SdZ4te2FN0PIDOmqityuiuOMlDRpqgbj1A5i8
         7kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703690337; x=1704295137;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLqxqDFp3g+3ctBYsDTo10ZcgpJFg083E8N42zGHui8=;
        b=CqoyfDasDEA++aoQr0URzAgzSJoKtkm6tac0IANZEnhwO7TtvdPuZIJqmcodBs55lR
         fTuVZM0xCnnZ7THPblYtcrvwlQyQJwUbfE9MK4gVwEdXQgg51NF/oigaFBntjc6HivEp
         bBbMCEgvUZYJ1aImBla4vQl+m5SSuPsbgBSnuh6gPYcAUUBWx0abuLB0P1OfJVgezazk
         EZnnQGcDIP4Fcv1CFdMrE6Lw2vyaqDXi4vfcBNKR7HNsw+N2EUs6a5dntIu72c6/x9Vn
         jUIFFejACbL/qQKc1qJlPGmDQ63Qn0FvYr09z9gFkzvHj9us5wPv3LIrdpWIszeiEXzl
         WlAg==
X-Gm-Message-State: AOJu0YxuYoTfPlwi25a3jI9zgKupZREHBCO7TLvmeSHdQXBxWEO9iNWm
	DJJyyDIPtIte0YHe7Nvj+72qI5yi6S+i/oUHPnmPPZ+SREA=
X-Google-Smtp-Source: AGHT+IEaKfAy25WQK5eNyuq98+hX1R8ubfyxj5LoJG9Q7+1uQ/ZypYr7jJNdkN01lBGF2xlwWxDSkQ==
X-Received: by 2002:a17:906:73c6:b0:a27:59a1:e0a2 with SMTP id n6-20020a17090673c600b00a2759a1e0a2mr262385ejl.29.1703690337230;
        Wed, 27 Dec 2023 07:18:57 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id gi16-20020a1709070c9000b00a19b7362dcfsm6652072ejc.139.2023.12.27.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 07:18:56 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 16:18:54 +0100
Subject: [PATCH] pmdomain: core: Print a message when unused power domains
 are disabled
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-pmdomain_spam-v1-1-ff0410086b36@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF1AjGUC/x2N2wrCQAwFf6Xk2UAbQcVfEZHsNmsD3QsbFaH03
 w0+zhyGs4FJVzG4Dht0+ahpLQ7TYYC4cHkK6uwMNNJxIjrjqzaN2PJcM2t5WOOMJJeTbyGNlMD
 LwCYYOpe4eFve6+qydUn6/V/d7vv+A074gn56AAAA
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703690336; l=954;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HOZ0tQ5XhpJRiYiK8g2v+oe13TgirBOq/Tfiaulf0Ik=;
 b=nysMJgbMvUy50OtruHiNQ2kL3c7am2LQt/62JQFIG7jsF27bNqouTR0XbOwsJUFbqapBgK5HA
 Zm7WZGoaxbWBI0r0Luv5UOKGQ4u3mM3mQVBee9h8DFA/PBWQf04fg+o
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

In a similar spirit to commit 12ca59b91d04 ("clk: Print an info line
before disabling unused clocks"), print the message in both ignore AND
cleanup cases to better inform the user (and more importantly, the
developer) when it happens.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pmdomain/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a1f6cba3ae6c..69902797a5bb 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1100,6 +1100,7 @@ static int __init genpd_power_off_unused(void)
 		return 0;
 	}
 
+	pr_info("genpd: Disabling unused power domains\n");
 	mutex_lock(&gpd_list_lock);
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node)

---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231227-topic-pmdomain_spam-2e86227bf02f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


