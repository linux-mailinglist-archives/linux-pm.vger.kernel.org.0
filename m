Return-Path: <linux-pm+bounces-125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A457F604C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 14:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D8A281E0C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399C250F3;
	Thu, 23 Nov 2023 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GN91Olpl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05633D41
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:32:23 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507e85ebf50so1079463e87.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700746341; x=1701351141; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7Q3RZYDKc2FsZpbY/DwgsOyJU0rLY3O3P98wvrreFk=;
        b=GN91Olpl6/5oqv4Tu0Bu8IBq9Iv+CY4EJCjk2OoTvz9Bgxvbv8gjo9p7ZTfLSB3o+o
         ITenqo6/BwFDrtsDICL2xQXeYrmhpVs4JlEI5F/pHKyW5FYWG3pY2lNmk1DlzlovVcnC
         YlHb1b/LVH+h8uCLMNYjOwlkGkfVXdmF8O/WMG34qein3AjXgGZggWmCu9Jmj7Uc9vAx
         inp+0HNr58ueOmNRikC8gdYh4zJMjYAei2/nefEZz7ggcQbNam3LzkvwVNL5FGvRFH5O
         TL6ymqeBF6nHSaHgrLiqvPCNeZy8KRY3dtvea9hmKsr7o1CqV8p0tcH8ae1PJ3nTmY+r
         Lpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746341; x=1701351141;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7Q3RZYDKc2FsZpbY/DwgsOyJU0rLY3O3P98wvrreFk=;
        b=Y0Pvh91sRnMV0ub4nGlxKGfZs/B5A5JrJHyf0qeSgLZYhgHnopJi3alQhpBThM/zKe
         1UKeEZpjosw+jV+tZ5nD6eGdmlAsv63r/xUZ0VUzK6s7/DYTZme4NqnhrIUcDaoLMvrs
         /XIYL9waTjFk9N1FJuYfee6deQ7Hf1KshDOhOibVVwWeUyCQIZD5IvouhJp9/Vf4BXty
         fQshOU6703yfCVJpyqmFqUZCZadc+57waKRrjepX1xXhLCGDSq98QM3BfBVoYpbLo9rA
         MEXZpJxtZIQYXpe+R+xo0RtnGDfBT4gzsj0X6G7OwBXfRG8yaEi1VQSEen5AumnE0plt
         gUig==
X-Gm-Message-State: AOJu0Ywj6hVtZ2AqYSUQAhwSDVwISAhp+bbZDoEj7n2OGWQ2AYPsLpzN
	XSdvSkGJLsi1P4TxogVI1Z/gnw==
X-Google-Smtp-Source: AGHT+IF40R3U2MxW68uTyxmtH1aJIFALjg4sxuSt8tZUriPCQEjkscRmm1ZCvWzkHU54ByIf9xZyKg==
X-Received: by 2002:a19:e05c:0:b0:507:a0d6:f178 with SMTP id g28-20020a19e05c000000b00507a0d6f178mr3590022lfj.35.1700746341165;
        Thu, 23 Nov 2023 05:32:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003313a1e0ba1sm1647658wrw.89.2023.11.23.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:32:20 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] interconnect: qcom: Introduce support for SM8650
Date: Thu, 23 Nov 2023 14:32:11 +0100
Message-Id: <20231123-topic-sm8650-upstream-interconnect-v2-0-7e050874f59b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFtUX2UC/42NSw6CMBQAr0K69pl+UkBX3sOwqOUJL5GWvFaiI
 dzdSjyAy5nFzCoSMmES52oVjAsliqGAPlTCjy4MCNQXFlpqo6SqIceZPKSpra2E55wyo5uAQkb
 2MQT0GVqrdN+a1tuTESU0M97ptU+uXeGRUo783p+L+tpfXtt/8osCCbdGNw1K45zpLw8KjuMx8
 iC6bds+kYh8aNUAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xj9eEaLtiaHWn0GWa1onMQEQ+NWKsOyiMFekEju5+wg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlX1Ri8Lf52DJM+paX1tAzv50+Vjq7jvSF9RTJfmtG
 4MIwTB+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZV9UYgAKCRB33NvayMhJ0VcFD/
 0U9Xo4OUpX2uri9oaJq6iX1GZbIp3PQw1fFV/FJqsiIA8b2qZb98iHhZfqip/UHRPkBjF0sPPM4r1A
 WuswVNHBrRgEP2FBnA7YTjoI+qZ4Ew41oEDZ2Y0GBB0X4yXGTP2VJigVRrczIMu8D9SS+ClkkXtYOe
 z7ZHGxSjuWPEHBBwNfQlJLuu0poNgfoOd2G/Rq47U2dk16xlfQNZSCJ7grXEd7v1OIBnpRphFcmPJ1
 eghpiq4AjtKg2WmyMayMzJ1/x6dYMwwPWnsN2fD/t/2kVxjFtgRx/lWHP98hbIKcnMqi9M848HlIUA
 5dyXe1uGQbyvoRADM3LhqO6LUXQliXQIYZ4336HxgVDZLo1vFtbIlox7XUyM9YEbjmXf38/v/RUOws
 h+BZ+ZvzU1vWcP0Ym1p2Eh6E2rzkqQtBiKTh4KahPRjae8EVfjk8XQLFkgcKKJ8jtEUwUAfONGRxPi
 YvCLJ5HaQekoq0iR+8ZcnSwaIquNozVvLXiwi/Rt329xrTovLApN3HpoXxEyxj5/ErOAmUvILAXvRC
 Zwt6rrUFYuHl7lT9OfBYSWVFegRUKdGQmU0L/h3hLQuRDFU0159pT3sn3SoDR3S+oZoHFa96uVaQ78
 kpfGgxFSnJeTv3QAi8WAjnVkdQ38uG+9Rs288/V2D73hpYYoiDmHWG1T71zA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This covers the RPMh Network-On-Chip Interconnect bindings
and driver for the interconnect framework.

As reported for earlier Interconnect drivers, the IDs
for multi-rsc voting has been removed from this driver
so the proper solution can be developed without having
to remove entries later on.

To easy Bjorn into merging the DT bits, would it be possible
to have an immutable branch with bindings shared with Bjorn once
this patchset have been properly reviewed and accepted ?

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Collected Reviewed-by
- Moved required block in bindings as requested by Krzysztof
- Link to v1: https://lore.kernel.org/r/20231025-topic-sm8650-upstream-interconnect-v1-0-b7277e03aa3d@linaro.org

---
Neil Armstrong (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip Interconnect in Qualcomm SM8650 SoC
      interconnect: qcom: introduce RPMh Network-On-Chip Interconnect on SM8650 SoC

 .../bindings/interconnect/qcom,sm8650-rpmh.yaml    |  136 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm8650.c                 | 1674 ++++++++++++++++++++
 drivers/interconnect/qcom/sm8650.h                 |  143 ++
 .../dt-bindings/interconnect/qcom,sm8650-rpmh.h    |  154 ++
 6 files changed, 2118 insertions(+)
---
base-commit: 07b677953b9dca02928be323e2db853511305fa9
change-id: 20231016-topic-sm8650-upstream-interconnect-8512d838c593

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


