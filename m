Return-Path: <linux-pm+bounces-23861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB56A5CAE1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295657A186C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD52222CC;
	Tue, 11 Mar 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgiYsUre"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780402BAF4
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710703; cv=none; b=svXcI0auAQhoPC54xvJhr/PbDF9UjhiPU+EdVtFo60yMflI3PdQUQjycWmYI59A1Cwd3KJPoxn+BqD4mQYIhn7PGUmBZxL1wpStzqvdDr6sIOHs+VkeHaW6CWbhnLwuRyrB+DQSxSP8UDrrxURQvlHsvBh9FGp3RinufY0unbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710703; c=relaxed/simple;
	bh=kUwSLJF4hOdQbqe05WgGTahSR8O1bhn+YoGzzL3yec0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZBZ8W1kt3W1xjicPpz+42TkEcGMia/NZqdodL6E4cvmrMDWnqwQTX1YmC+T/AtfeCd4iQW5Atbpsyllawhtdkf77JLbOt9+l374IVT898zNOpV3TZByafPhY9yQMZyXnXXkU2L1uULWoJRQuT1nhy8riEzy7nGkRZBXenMcrAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rgiYsUre; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cef0f03cfso19127295e9.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741710700; x=1742315500; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSu7pCZEYrCnqmq25VgGLb8Q3akox4I7nQ6eqPw6g7k=;
        b=rgiYsUrerQvQnCUlMGg67xJO3TlwQDhDmw8MlEoijNT3CJOq7FMeWv8hC4P6cvRin5
         rguAGlEdxL9x/9i/+W8iDBXxy4qke2IZGU3XI/2CXw3xSEs/9eAoRguvNyWUVXZqnyZG
         0FB8bgoOjGqjm67t5oMnNZxFz7wPTV41JZsFE/m0pDwR+sbT3n9nEw+Qvq9X4WUBmqeT
         vATO3d0nh35iru2j24IJOrtGJ6zslPvCU7bnpLsfTm93lnfaTyU2NCBsd+RCTPWFDzVd
         2VcTYPUEl9wC/ktLifSHuPTY8sVgULMosunwbKiki0HVbY2hkK66kWls0HeyV7Z29DED
         S/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710700; x=1742315500;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vSu7pCZEYrCnqmq25VgGLb8Q3akox4I7nQ6eqPw6g7k=;
        b=BSbDROiyDMpm+VNiin4QrsYJPHUCiGho2jXiMjSJL7EL4NSJP2EmHlgh3AbmdskK6m
         SjOx1d60zCSdUiZsbsjSHM9zLmHumjvcDYNH6wU0moaH//Z7K68MSb5flNezsbxm5lEt
         jr3SjrTK8VYf5aqfkcU8h4Hohk1Kx5BLvHkJGIEFKAB2w2Wi7+FlrqZ16pA6uOyC5vL/
         6e9pHMDm0PYErThuCuoQEf0vBeaM2jQVzH4xUPT+G6dBkAQwhaiMTM055JHbZfkGHWUM
         tiE1gOzWTxVS5WOQbkdV4zleXAIpMHX+XYVn1pdsJ2BxI5rmRc9RY/ru8MT3+TOzLkHq
         7mSw==
X-Forwarded-Encrypted: i=1; AJvYcCVUnqJXyrsdbWwitHuwdT5BQoFlnrdmZiQptJFWKYTRqhGETDjGp9YtGYnnPepiBQpIo0uWv1RLyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdoHMKEriLnbY7oayw/uC/YanBN129FObf0YJU+Ex0nf+wLceG
	XoJsRT8qvHgHatB7zWxEI0Rj40IODKhXiF+SInt9n06YNuVY6E8q8dlpKIrfn2A=
X-Gm-Gg: ASbGncua/W87XHWpIS7CAqvQMqCdWqmmCYNBV9pYwV2/yxXHjEzDlHNfXk88/ek4IeX
	2d4F1a2RO/dTYiCMT4rNUbB1h+6HzSyHNSLzqPRkpln6w8WHv1FVlXKETOzyxPMCbPUjuuZd5fB
	CUjpsc3Yk7jhCa/m4dmcDsLruN9/NEqO0qFcWri5zq8Jh7E64PXnOdMqHijodofR2dJGRYvgUNm
	KnFlBnhcVKSZaOj5jXvpYwAfnLyQf/armxrCdCpwaxttcYb8GlglEv/+kiUUknp5KmS+/ljFORP
	7wCba4E5JFzehbkimCiOV3/zQPbd4UwvhPnrYgrLc47gTRB0OZ3tSvLl3aKCtTKnkT6r6929iyU
	irEhWxCo8QxBojzKmx2Y=
X-Google-Smtp-Source: AGHT+IFS4aUQiV7x8CN8VSXnMYNBbKlCZFXiKf5/5Sj3gUF0kD+cf5WTa8UiKknMYgy4WZkjt3G/sA==
X-Received: by 2002:a05:600c:3b0c:b0:43d:7de:16e3 with SMTP id 5b1f17b1804b1-43d07de420amr16884685e9.24.1741710699801;
        Tue, 11 Mar 2025 09:31:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d031d0e41sm22010545e9.0.2025.03.11.09.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:31:39 -0700 (PDT)
Message-ID: <483602d6-4ac2-4785-b205-912b59fbd6f1@linaro.org>
Date: Tue, 11 Mar 2025 17:31:37 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM mailing list <linux-pm@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: TEO as default governor ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

I think we can agree the teo governor is better then the menu governor.

Would it make sense to make the teo governor the default governor ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


