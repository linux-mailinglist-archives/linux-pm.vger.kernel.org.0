Return-Path: <linux-pm+bounces-37439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58474C34FA9
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB587189B7D3
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE99309F1E;
	Wed,  5 Nov 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUCy+3WC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3BB309EF3
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336462; cv=none; b=dvr+uO5T9UEcYITUIb5A42aF4gHa88WcHBAhY1ZAglP22wz0Ka2TGO/N9YEKpXWferNI8DbQDJwU4wns0k35rLCogukRhldKe1LTDUDGKPso7ZdHK5z9tVwI516GB9S8ZIaL2DhKLegjSksFfED10jYaLJvl0mXooo/tCgFxFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336462; c=relaxed/simple;
	bh=vkrIwm9lK8ZfUL86WyAB504zYSG51FRu5o0iM+GLi4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BICfk9hkkLq7v+NKdB4QhNtvxkZY8lN81wYBCFFyHgveL/x2ScnuEScEW1rlWtpj8Afif2R+Iu6leqWjsbQLD/MM9bRO6dmcA0Bk5jJ0qtyryelIzrxyKgtVyf2r8t2MSkBnxW0P5qTISBSpRhbePimJ8L/20SZfnSDiGiWwSGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUCy+3WC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso1254031566b.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Nov 2025 01:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762336458; x=1762941258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vo1T83LxmrpztjRJzJByTAsIReSJO+KD7UPLut/mg+o=;
        b=WUCy+3WCUZLKAbJgswuWAEIn+AC1xoEDiU4yVKRKhoXqVe7zt2vQJzfwE+7SxcmG7l
         C9mEqOvTIfHsYwmw6KzX0nD/gAsMoEkZs5wA3SEX7lRvQjfE+RISysi5grFCPzaamzHK
         i1r6OOOywIZfzem08/kYEH/XkFTY5FKDtHDXM4bZzzlqzDOKQwO3/LyvZ8uMf97KyNlw
         acJOMR7/NweXdf9117EuopZxdyd355p1R7T61VcMSH5ELiW2rF5PELSUpp1/pbuH6xW5
         7/OWiH4bSwrrr8K1gk37fN+8U1QSZJsuOmEi+eesjX9YH/5qEmzQ7te8N1AuUGSKTGbJ
         GFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336458; x=1762941258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vo1T83LxmrpztjRJzJByTAsIReSJO+KD7UPLut/mg+o=;
        b=Pr4uf+eE9q/0AwYg6pJX4cHiRG9D++aTRFHxjtb3O0O/1UI2MBbchQs7snMfp1ALHf
         YOk0+smMgexVfLHMwEEFmXfDeueO6pn+Kevcw5gSX+UohjvSiQla+zRNjwYyfB7aQgru
         +EH2ySnnES7kh9vf0ZjrgwDXTDIbz9UW2yIIYgNbYE1I2j39HrYHDd50fWaushEKfHq4
         THXZ6OwnIyK/43etF0+fsXhTC3PTs9e7wuqLbey1eauDQgqwXCUSgxrb2cTsTIIaIydO
         7bJb3zsXkQ8j1zYztIxDe9wdBF1Q4vi+06m4ezVKW/Oo6ijHfWJv4HRyaWNW5izXxOFW
         RLdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtz6WiqEDYHKEMrczMrHNoYNq3WFnucJCWbaKj1L0kWKTHuSfJzol94gqXWuyiL3FE3xCIMidYBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PZJoGh6ozX05AZ2gjMZVdNGxqxsDsnZy/YVoWtJwXHdb2Gk9
	vrbCHDl+Bn6SbC++I1JSS144ZvjqjsyDGQpUD1aXRJ5+a3X0Tx/bta9G+S3nHehWQ4Y=
X-Gm-Gg: ASbGnculIaPskFtuR1lnvBJJnEd5cV/sJ5p5YCTSWItjyZ8P41/52mE6QBJrCALPqtQ
	iN+G+EnUsucdhw4+I2zLHsoblmeXKpwq8OI5rXAx7dfxmy1E2tJBFFIBz8D3vk+WKRSj4jTnPTb
	3VXIPRaWZfa8oXeMwMqEC8Q0WmOQ6mIzeT5GaN7BdPLWtA2Wkji3lVNIHEKrKcvOcdLisl5JsVi
	UY4OGWXXCDdcq/v8mVIuzdlAdPp+jow5jdZMclHT2KvCPYtKqYnNcWqnFa7zYVFhTYm6/2sF2lw
	r/ppbTfUDCEDTzAHNjeK0ctVSJF2gkZEOqrWqMqPeEI+jB3hfaSgNLbS/I/lWEfPK48cjNgsRnI
	SkZ3JZJpLI49Dc/3CvygHkKl4UF4YJTSqzO0D1JTF69q7PG3zlk0hgTS/wLr+1tGebsDAlAxQyo
	8GkvOQ6oxxXytlf0VarZkht1ycF1Sh
X-Google-Smtp-Source: AGHT+IHToCJ0Tsc7PHqd+smQCkA2ppkm0fPmpSqpXEr36IzGbG2jcO6xOfoqNg0L3C1H8yEX0SGCOQ==
X-Received: by 2002:a17:907:6eab:b0:b72:5e29:5084 with SMTP id a640c23a62f3a-b7265155b74mr242771366b.4.1762336458345;
        Wed, 05 Nov 2025 01:54:18 -0800 (PST)
Received: from uffe-tuxpro14.. ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37cb9sm442571066b.61.2025.11.05.01.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:54:17 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 0/2] pmdomain: Improve idle state selection for CPUs
Date: Wed,  5 Nov 2025 10:54:06 +0100
Message-ID: <20251105095415.17269-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms using the genpd governor for CPUs are relying on it to find the most
optimal idle state for a group of CPUs. Although, observations tells us that
there are some significant improvement that can be made around this.

These improvement are based upon allowing us to take pending IPIs into account
for the group of CPUs that the genpd governor is in control of. If there is
pending IPI for any of these CPUs, we should not request an idle state that
affects the group, but rather pick a shallower state that affects only the CPU.

More details are available in the commit messages for each patch.

Kind regards
Ulf Hansson

Ulf Hansson (2):
  smp: Introduce a helper function to check for pending IPIs
  pmdomain: Extend the genpd governor for CPUs to account for IPIs

 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 include/linux/smp.h         |  5 +++++
 kernel/smp.c                | 22 ++++++++++++++++++++++
 3 files changed, 40 insertions(+), 7 deletions(-)

-- 
2.43.0


