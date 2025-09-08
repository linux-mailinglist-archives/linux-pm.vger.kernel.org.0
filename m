Return-Path: <linux-pm+bounces-34146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA1DB48A89
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8179A1B2617C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285F220F34;
	Mon,  8 Sep 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZaET39O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA7A945
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328502; cv=none; b=Sn1tJW3mw/yYldW7/OtyZ72/DveP8zHIvDAdKrMxtLFVFMAgH7+9yZPhsvAhbs9ISXHMDHNtide4YrUcF4S5wJhw6zj9SSqCtFryxfKj/6fUfvk58zFwEyMkXDzAHM8aUYN1dBUaiWfgJ6430vgwBfBusBYSATNEFMn3lcBmCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328502; c=relaxed/simple;
	bh=aooWlxs61oe5XmAvG5mEG9jZb11jz6KzCxSNS1Hzn4k=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=f2e50j1cTjmvghgMwrtQn0tPREc41EVeYmlwQsZ4qx3mPvZVZmT8mGHTvgVPjhqDbO0yTKNO4OrDKicnA3GoLPy4BRBXmzDpb7yGz7VhFmX8/S2VcgGyJlNRhW2oX+Xv0H1IB559kyIfPLHSiWVvZb3qgDMoy2+/9jAuX1oO2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DZaET39O; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so25224605e9.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2025 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757328498; x=1757933298; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHs01z7oM1ANWId4X0P4WXVaPJBWZpLLCmKiOd/Ff+A=;
        b=DZaET39ON3QQRCLbqo3HcytUB1zoTavH3MAq41xiZRj4PWLwqk06hD2ecjQQpOneo5
         h4zIR1IcQBMhssnq7xl6gyLf40YwIOE3aa4uCMiI9Ge7ze+FAiVKkteHB9vOULiH0VFC
         fVBTHZAofKFfe3tLfzwyedNLE4MLjpvJI6yR5RS5j/MncaBAc08iCYxKYLANFj4UAm1e
         idVewv0Pw4gVJBYtojNrR1vpBBYfuPlvspE0i5/MXQwLzuMZMZmHDQkvm+z2Th5EDix8
         PpplO5WuVSDBcSdXILz7FW4tJjQ/l9rY0i+qXlg3fYZB6aSrkf1NuVB3n8UFpvoiT4bj
         0gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757328498; x=1757933298;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vHs01z7oM1ANWId4X0P4WXVaPJBWZpLLCmKiOd/Ff+A=;
        b=Z795j/8kLJYG7I9DsyuBwFDzQq9xXWQ/wtXlnVS1R8wAn4S2BD2jVUTN1PwVUV5ZRR
         i0JGau9awsFLANalYZK5SN30hfEj36uyuL6QAu/hvCBwyxqBO7dfsSqRTWaZ+gGpo5v1
         dASgEXQtykeZxwfuvhItU8uRLhJPbH7r6VoFxkcEPpbUVNowDqKNoAb06AV6qCQf8If8
         g0iZ5pG7R2510jEdSepV4SBzk91NIf+OhSyXuQ0Ty4Cj/Qta6u43MVIsdKhL70b0rE9V
         TFGb9y7HEzyeARqv0A/l4VR3jonEBlSZj41pZ34dQXKQypUzz4IuV+8cfvlAI8+v5Gfg
         bA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXda2B6hN/7Pq4IHRnYtYnS8NW+/MHp6IYz0Yvo6KVkFvepp5LuyxkD8HRWeYe2kk70NHmGlJ7W8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0LS56g8vrn0R+IRHUjjYS9vh3w6QFSFBXDFc9SNVQ1fEY2Iyn
	wU+axdLSFPf9T1o7s32XshVV+qt0sZF5Wz2j/k8tCx79UrMOR3N+21Og+wC5pYJIuUM=
X-Gm-Gg: ASbGnctOnygYdwwERuZFtYJHVhqsRlhZXi43mODoJ2TIv04Rx7gCwNWzo/VxnBzQX63
	IVZd4WVWEgyXjU4lyTO6mjXDM+nYyJ9VAJIN2KZQekpssDyH3ioVp5lJ7dUGBb6yo3o8cT0Izra
	hcByX3vfmaKcVUeRVu8GdOcgw7kubDzlDgtguxHYjVpvqOX9DKPvdwJTiqFTITbjYfwdXEWEbL5
	TfK0ZiQ0/3WHDsAhNXd+ZubfQ6CDBNsyJiVPbEWx0giCBo9W3AeftZhShafSs4FCDGXbDTqz1qO
	rywo3pKxsnCWGwKR+lmyK7MH7cKI/MuWtTI5iNEmb0j+4S7ZrQZCqV8ztwREkpTg6i7ShvPUeAp
	0/MEV1zllghxHU5Wj1is/vjBqUe78DFNZXZHE7LgYlauNse4Qaqtc56caO+eD0zrbK82y2CNjQ1
	XBON6jzS0NaFI6
X-Google-Smtp-Source: AGHT+IHPhOXQXGFj/kIOadcgTuaRxf22+4yFciHzJcYi4juLw9HJQxPZ/k92mxlesnF3xP6w9bAziw==
X-Received: by 2002:a05:600c:1d24:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-45dea83f76bmr8038565e9.19.1757328498296;
        Mon, 08 Sep 2025 03:48:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9b6a:7b16:fb30:a294? ([2a05:6e02:1041:c10:9b6a:7b16:fb30:a294])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm140785655e9.4.2025.09.08.03.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 03:48:17 -0700 (PDT)
Message-ID: <2af92349-2c84-4f1c-b035-946c3996cd9f@linaro.org>
Date: Mon, 8 Sep 2025 12:48:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Lukasz Luba <Lukasz.Luba@arm.com>, Saravana Kannan <saravanak@google.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Deepti Jaggi
 <quic_djaggi@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Srinivas Kandagatla <srini@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Abel Vesa <abel.vesa@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: [CfP] LPC 2025: Power Management and Thermal Control Micro-Conference
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi everyone,

A Power Management and Thermal Control session will be held during this
year’s LPC, as has been the case for the past few years, and it is now
open for topic submissions.

The Power Management and Thermal Control microconference covers all
things related to saving energy and managing heat. Among other topics,
we care about thermal control infrastructure, CPU and device
power-management mechanisms, energy models, and power capping. In
particular, we are interested in improving and extending thermal control
support in the Linux kernel and in utilizing the energy-saving features
of modern hardware.

The overall goal is to facilitate cross-framework and cross-platform
discussions that help improve energy awareness and thermal control in
Linux.

This year some big topics have been identified, for more details, please 
refer to:

  https://lpc.events/event/19/contributions/2003/

If you have a topic connected to the big ones identified above or a new 
one to propose for this session, please go to:

  https://lpc.events/login/?next=/event/19/abstracts/%23submit-abstract

and select "Power Management and Thermal Control MC" in the Track field.

Please note that topics should not be about work that has already been 
completed, as is the case for LPC in general.

The deadline for submissions is October 15.

Thank you!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


