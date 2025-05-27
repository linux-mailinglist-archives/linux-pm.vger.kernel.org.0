Return-Path: <linux-pm+bounces-27675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD0CAC47C2
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 07:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8897A3B9B3A
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 05:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3441917F4;
	Tue, 27 May 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0hd4Lo3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CCB3594A
	for <linux-pm@vger.kernel.org>; Tue, 27 May 2025 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748324728; cv=none; b=uKsDX+uFZWKK8+AmGVOsr8wUpQ1WDs8eNVZfNTBRllmcbeyO8pMI6sa/ryjilZB76qp83jiXE1v10lMRUw+924+nD00Av0P4i+uUYwF4X9arw5cLnuOzXjQ/dGaCWH57y5kAKpyN/GgJCT2CXYto+dlNXIX7PPO1BeD+yN4axIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748324728; c=relaxed/simple;
	bh=0h4MToyMZi6FE1TFu8zlRTj8kxMLKoCJQR+vUO1Zo+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l6z8zF9U3Lxyhnlcc/x2FqzyKP81t/k4+Gu4u3higst1fzrB5oZmQHJMLxrj3TQl0XP92eLaosn0Mhf7ZkzdPa2HMcNx7c4nQlaIJ1KIf5ngzru5/c9FmwiZI4tABWgTHL0KvRb8v/FYzVaO0R1wOELFg0xp/n3iI5tlAg7a4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0hd4Lo3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6021b8b2c5fso5647290a12.2
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2025 22:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748324725; x=1748929525; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAdJ/cT5QBHscP2gZxi7G3d4bBHjxu/r9X+j+h7O9D0=;
        b=R0hd4Lo3WYkT3Iyk5DCwvJIBTQndAZkhtQgNYIRb8n/+FrN+xHMqPB8Xu0mnwJlNq6
         qpp1SAPXiAZ5HrxCXJLia/M+U0qCs8RwArRXvuoHDyZh3hMZ4SOfFWxu2ngzB1VBtam9
         HZNp56aStJbmWCMLUWm28z3ogTeUJ468dCM5iaaqu9VvJrWRvTbCDeC4I7uiVd4WQo9c
         Igr6mnLkeTrJfj8LsgCbHCUHM4EUZ3tbC+jtgwqCAMr9Uc/CjiTHrPQktgE4X00kVEcl
         sqXScoa+MOEt8CZ/5Em33aGru5kiv4Yfw+pBQfHOdnPOCJ1qHrCfSbz5dRw/6x6MvHzS
         +5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748324725; x=1748929525;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAdJ/cT5QBHscP2gZxi7G3d4bBHjxu/r9X+j+h7O9D0=;
        b=ZeEwn76woW6LhB77OCvgwoRlxhrqLEi1OU/p8/BZkXvKtDMPFw2kU9uQF3qMvzKcvO
         qmSFpG9MpxnuGmCg9dHUHjCQ4+aBCRYoMPSszBonY0ndB4vqfZ3YAz0dqclSu48+W8q+
         e6sxZiJbuB0k3d3HVrqtK4Di6HJYDZpE/29PMRROlMNvYakZfMMnVvLytvlvpxEqQxMv
         Bp270gAfHHMHRe9ijtTXC/CuoogvT32bZ0LxJDWjHjlvIRzAbvSH8Fj3xTfySypD6Y5J
         r+Ht2k5l3UuBenpqKRuk983tmH3x2ppIQ3dVG79Oe5hu2OoZ5NG9uJqhZwcd+D1yGU/3
         v9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVgQKiCReAqGTrPgXzzWSDkthuN4JTd4BMnajB7iDYAdn2t9BEVfSKkP8EX7sgLaJ0BALgGimwQYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzaY6MapowHsGGbUQGhp9UCpy6eg9mtIjyaULf7kHSKu2knHl+
	iL9pHnlN8eEnAdi475vFNuMjKf/4rxh6FWFYZAeIY6WLHQqZu9P+Lgtna00ue7qwrw4=
X-Gm-Gg: ASbGnctX+/g9mkbOKuGYkUTSJD40P/CKHR0j1F63BJVTm9XqnRnc8PuxN0ZuxHYfd3x
	3s48k7lZxGb12cOnCWkOHCZykWBXoiNHMcwVDPYdX50qsVhalhsWl+1nHrP9F639xSkRBzSLlql
	5/+6ywOVR/ieehV93khEqqmnXwI7xY0Y5OuwKpkBS3xOTxXe6nSyAvpLe2GZsFe/q9A9Jpegp4c
	ahyrrPczG9uWP/RXd6adwFaJrGysEtfdKJSKAtaIFkLHjPiyYRfDlv2ty2O3vC7tr5ELvMHnli+
	mnIf56P34wCw116BRSvHKqGOCv/d9tKyFmuUiPGmVO4axuNpZFxPUcX2UHVUrGs3Krrv7G985Qs
	=
X-Google-Smtp-Source: AGHT+IFjfjGDL9+pR2wI6u63W8YFLk9uDG95aJV/jaoLvZt0KxL00PabZAJ4WGFqwimBN1PB88AkOg==
X-Received: by 2002:a17:906:f58b:b0:ad2:499d:dfdb with SMTP id a640c23a62f3a-ad85b1bd259mr1048071866b.26.1748324725279;
        Mon, 26 May 2025 22:45:25 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad52d047749sm1788284566b.8.2025.05.26.22.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 22:45:24 -0700 (PDT)
Date: Tue, 27 May 2025 08:45:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] cpuidle: psci: Fix uninitialized variable in
 dt_idle_state_present()
Message-ID: <aDVRcfU8O8sez1x7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the first cpu_node = of_cpu_device_node_get() fails then the cleanup.h
code will try to free "state_node" but it hasn't been initialized yet.
Declare the device_nodes where they are initialized to fix this.

Fixes: 5836ebeb4a2b ("cpuidle: psci: Avoid initializing faux device if no DT idle states are present")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 3c2756a539c4..4e1ba35deda9 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -456,14 +456,13 @@ static struct faux_device_ops psci_cpuidle_ops = {
 
 static bool __init dt_idle_state_present(void)
 {
-	struct device_node *cpu_node __free(device_node);
-	struct device_node *state_node __free(device_node);
-
-	cpu_node = of_cpu_device_node_get(cpumask_first(cpu_possible_mask));
+	struct device_node *cpu_node __free(device_node) =
+			of_cpu_device_node_get(cpumask_first(cpu_possible_mask));
 	if (!cpu_node)
 		return false;
 
-	state_node = of_get_cpu_state_node(cpu_node, 0);
+	struct device_node *state_node __free(device_node) =
+			of_get_cpu_state_node(cpu_node, 0);
 	if (!state_node)
 		return false;
 
-- 
2.47.2


