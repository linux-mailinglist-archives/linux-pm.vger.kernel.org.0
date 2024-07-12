Return-Path: <linux-pm+bounces-11031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF7692F898
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B06B223D3
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3D14D71D;
	Fri, 12 Jul 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKcfqs8U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540913E03A
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778427; cv=none; b=VB4pL0AA/pfVn8UULRQ3Jk0sDh2SMR6cEvCYftwRdlUcXrVbTm5Cu8dqc6TZ5JIDzUmj5QvNilirR7sIF+BUFvHbESPhQ1qv8kMgX50nMI8z6V6eEV69NdsVqFobmlYL5deVMHqQf4k8/M4dAVcUjuPuwrAyX6DEAffx8hIL6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778427; c=relaxed/simple;
	bh=rgfGe+n4aLY4lJb277XVowuNUYiTJ84gMEi9sQ/DjvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g5glyZzvUoSp1kbGWRBMnrgLfJgavilyOKl5R7WWSGPD2fmHh9LfnFJei1+zlFOxlwI6hjWlNFH7eu/e4zNWNiDM/e+Y74G5bXqZLfrvL3j+SO88+b3y8AtHETr5AuevVLFy50/B/PGfKysYni++//h9AuOFBbIXF5QnmEpjnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hKcfqs8U; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso12615645e9.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720778424; x=1721383224; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSsytuug3CRKYELeUghAkPTYddqwto5qSFyfJvfzsKY=;
        b=hKcfqs8U4nBbsvTyDSYx3zsKWYT0x+QrdHUGnnV0j3DUHePVF1eAGLIbCGKrBp06JG
         nRQvqOyW35ZEZhFc1LlYgW+RVdgWFQfI2tQ708emrGZLfP2AUGSgPwmKCKTrAHPFXUBC
         C6P3tcDTXliDPnMRFn3IHTQimzrMKY+C+JoJYQU1cHSlKUUtzbxNG20WntPEW3HOXotQ
         WF6d/jr+y/06EuvcAmA130DcTy2Q9GaLgyfoSM2QwJzR1wXK/C5xuMBFObZjky4b4Tju
         +A3wfn2b90gSLBy7FO2dGdMfObAp6F3ZMcImhkfuHJIAn6katIxkaiJW8lhHOBkO2VhI
         jm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720778424; x=1721383224;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSsytuug3CRKYELeUghAkPTYddqwto5qSFyfJvfzsKY=;
        b=qxiJPhkpUMuHEI/2RM/IG76CHSSQMw3SS8HBR7IIu1tcMQqCFDyjAn9Rs5jNdquI3D
         Cm7QbdKTHuzUfU8+4jJfzBjgyp+T500ZHOcwSj6Lbn2TQps7m3VeDCYHZR6ktswTkQJU
         11JeXWi/mDncma0nd+Ro+z0v+X8ZiJXXuS4HLcahGhRqx5Zuxu7Ndl0q24XGba3Zu/04
         VXi8w7Y8jPHpEZgsScbDlAeRFyLlXQxpT92TVz+lP+NE8k3gDAgB/mQrNadghSFAdnHy
         5ePZbxMv4OaE092kurkGOmx4XrGXRyBI5wF7C5W+iu/GI6AwZFp/itkpb+9fqo0VFlCt
         yDAg==
X-Forwarded-Encrypted: i=1; AJvYcCVRdO1GQtfCBDTlt7/gF3vdyqKa9gaOicjnabSKXMZJtEd5RLj7V+GheyQW6juSieaMwLEqvstm8WuDRg3NxlEvdm65LCRRgqI=
X-Gm-Message-State: AOJu0YwN6EEYpJSG4xIsYKUgxD4Pxjj3PvN/Nl9vfiW3lm3DaUstj1/f
	E+KJ3FctMk92hQaB98ldl+3Vf1zxz7TH0GUYoCrnos3Exx4oVKpDEf39W/ldH+k=
X-Google-Smtp-Source: AGHT+IE4X36PNQS0IVul3KYRWEkZF9TnHf11aAzYXEcD9kLqBbfDlDwUZknOIMZ6msu0SsEo3y6NLQ==
X-Received: by 2002:a05:600c:42d3:b0:426:6edf:4f41 with SMTP id 5b1f17b1804b1-426705ced8fmr86596275e9.8.1720778424394;
        Fri, 12 Jul 2024 03:00:24 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:cbc0:d3ac:530e:4e1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f288470sm17641885e9.23.2024.07.12.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:00:24 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 12 Jul 2024 12:00:03 +0200
Subject: [PATCH] power: supply: qcom_battmgr: Ignore extra __le32 in info
 payload
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-x1e80100-battmgr-v1-1-a253d767f493@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKL+kGYC/x2MQQqAIBAAvxJ7Tti1IOkr0UFrtT1koRJB9Pek4
 8DMPJA5CWcYmwcSX5LliBWobWDZbAysZK0MGnWPA5G6iQ0SonK2lD0kRWyt65zx1YCanYm93P9
 ymt/3A5ZV2yBiAAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.13.0

Some newer ADSP firmware versions on X1E80100 report an extra __le32 at the
end of the battery information request payload, causing qcom_battmgr to
fail to initialize. Adjust the check to ignore the extra field in the info
payload so we can support both old and newer firmware versions.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/power/supply/qcom_battmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 46f36dcb185c..a5b5f1251af1 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1007,7 +1007,9 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 		battmgr->error = 0;
 		break;
 	case BATTMGR_BAT_INFO:
-		if (payload_len != sizeof(resp->info)) {
+		/* some firmware versions report an extra __le32 at the end of the payload */
+		if (payload_len != sizeof(resp->info) &&
+		    payload_len != (sizeof(resp->info) + sizeof(__le32))) {
 			dev_warn(battmgr->dev,
 				 "invalid payload length for battery information request: %zd\n",
 				 payload_len);

---
base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
change-id: 20240711-x1e80100-battmgr-1eaab3b8f024

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


