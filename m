Return-Path: <linux-pm+bounces-8089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9748CDBED
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 23:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF3C1C2300F
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBC127E0F;
	Thu, 23 May 2024 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWIfwZbT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDB126F37;
	Thu, 23 May 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499511; cv=none; b=kMAR6qDXYoXVr43uMf2m/YTZOs9JJtyxYVXOG+W1i7ZPWhNQKhUUdkpIg89C+evyE4s2jiAYUXByZ7zrKB8rcBCOyooeJTOkFOZKcTHWHmj6IC7kRfOPi6akJovMIqKMvF9jldnjzKLzbjJzPtOFVJr7BvC6HWJPzIgrfjbw1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499511; c=relaxed/simple;
	bh=VHdjSkKxWm5rfyGLl7Yk8K1zO0mB7odDFsgg9+Tfu8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qic4VedKoX/kUbbmtxTMynylGZgeeiE/qgZAxi9xLfAmEf6FuxvitJkQxc/uliXjR1FbsJowm7GqaEHpLOs+NcErr0U9znxey0ozroHfFIY2V0ce3Ggj0jWvZieMPRl/1NK1VS6gWkCkfO8yyVrg129wkBGxNA8TQVjgC0iWobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWIfwZbT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-354f5fb80d5so1311176f8f.2;
        Thu, 23 May 2024 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716499507; x=1717104307; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+I9c44cbx3EWc9H7lfkabZH5dwju+xdfdQpItJBfjY=;
        b=QWIfwZbTOC0zEO33zgidA8aomQoEMAc7IufXEgzDrQWlv2hpHckHBomumWqhpxlAAc
         tn7C5qtv8anrIYE2UiYgfl5wormneDaRUjwrvUEdm/Zn02Cxtg23cr4E9cEM7GeEtAmD
         rHtoqE7JrmCjnYdwASNQ+nRdH7mLmY66sT5fwFExmLNBWz6dQBahc+96V/byn7iRBW43
         FyuoUYbRsw1V64l4NoqQW153QfP+zcuHU/llMWFtFtTr5bgKcZkn2O/wuiLzleC+MMnr
         UHHYecMQElpyQpXdM0fzKiY2WKWAuCFVV3XdDhIrnTiollXHdJ2LAfVoUYbM8z3P00Sq
         aHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499507; x=1717104307;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+I9c44cbx3EWc9H7lfkabZH5dwju+xdfdQpItJBfjY=;
        b=TJTWdFdE8khAB8/NpCLRVqnNZoP7F62l3LB+Fnn8Y04aQY/ADBEEP4gjtqRaBYlkWs
         Y6Ljpybjb0dqScqytWpfkNMqJQhr1rYsqqL/rIVo9bd/MIdlCVHPoEgYtCZVIPmpsL3J
         /0a9c5WE9fFKPgqKtF++c8cnWMo6ujgwXZybLptSNh/AykBZK8YghygVDFTMZszpMp+d
         t6WDlQ7+Hs1Km8OPGh78dfEXzfZddh7OnjyS1WmYRH3GxqiBNko7CptOIMoGg8+tXvE+
         Y1uA/Yg0PcJkvdSq3u11mZiKagq1sumRqYR0AIeQ4rzfvBlv3PNCJJmHFrYjwKPV43Js
         SC3w==
X-Forwarded-Encrypted: i=1; AJvYcCUufJrHGoGi0Nc58UaBXSHMZHcDBE61rcwfLR8MUXKlXksb5boMdURnZLVzztX6h+xWfS9Xew+ksYjYsVRJqLC7QQH1pwfJQK38QxbGNO0MmgDpCoVX9rPHrD4/59c07qo01OLxsH+RkRCAk/FlBFlv+U9+wEgO78Jd72rkNpE=
X-Gm-Message-State: AOJu0YzQaSqxT5dNFdm9mhaEpO95aTUilPD9Mq3S85sFRG5XefwjvzoD
	eLIK0cdgklZP3bkj1hrgmo6MeH7B2+ZCoH2nFtsKuRxB1XPU4mmyzehjuAJ3zXY=
X-Google-Smtp-Source: AGHT+IH8OD5gV8/1smKKDoZX9EgdPWl5N+fjjkenQw6jr7OYD/hRr8503cKcLcTN5wI0POCJ16VABQ==
X-Received: by 2002:a05:600c:54c4:b0:421:17d:1ec1 with SMTP id 5b1f17b1804b1-421089f9d92mr2601535e9.18.1716499506783;
        Thu, 23 May 2024 14:25:06 -0700 (PDT)
Received: from [127.0.1.1] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm2522955e9.38.2024.05.23.14.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:25:06 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] cpufreq: qcom-nvmem: fix memory leaks and add auto
 device node cleanup
Date: Thu, 23 May 2024 23:24:58 +0200
Message-Id: <20240523-qcom-cpufreq-nvmem_memleak-v1-0-e57795c7afa7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACq0T2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNj3cLk/Fzd5ILStKLUQt28stzU3HggzklNzNY1SzKzMDJMSTI1SjJ
 UAhpQUJSallkBNjw6trYWAK274S1sAAAA
To: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716499505; l=1291;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=VHdjSkKxWm5rfyGLl7Yk8K1zO0mB7odDFsgg9+Tfu8s=;
 b=14d9eQKhZyHNHy3nsPQ8V1gTIq1GdV//SoUiwVSvFMrNQfJq/NT5EnqCuIOUXdL29hOEemMpn
 1x9zo3p7LKYAt1mKWn9Bwdn+AKuTBdXDc4saqt3Npwyf1jsQKQphVHX
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

There are a number of error paths in the probe function that do not call
of_node_put() to decrement the np device node refcount, leading to
memory leaks if those errors occur.

In order to ease backporting, the fix has been divided into two patches:
the first one simply adds the missing calls to of_node_put(), and the
second one adds the __free() macro to the existing device nodes to
remove the need for of_node_put(), ensuring that the same bug will not
arise in the future.

The issue was found by chance while analyzing the code, and I do not
have the hardware to test it beyond compiling and static analysis tools.
Although the issue is clear and the fix too, if someone wants to
volunteer to test the series with real hardware, it would be great.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      cpufreq: qcom-nvmem: fix memory leaks in probe error paths
      cpufreq: qcom-nvmem: eliminate uses of of_node_put()

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)
---
base-commit: 3689b0ef08b70e4e03b82ebd37730a03a672853a
change-id: 20240523-qcom-cpufreq-nvmem_memleak-6b6821db52b1

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


