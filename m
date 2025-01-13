Return-Path: <linux-pm+bounces-20294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A01A0B0BF
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 09:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7C97A2D57
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4428A2327AE;
	Mon, 13 Jan 2025 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Pk98e29E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910ED3C1F
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756046; cv=none; b=Tw41lS6te/f/FBXT0fEGWOaWvvil+9GEx+cPBvNxLF24a1uFkPlQtnFa5VLVGL/b/BADDtvYEAcIsZX6IQRbRg1BCFVQT4LC/D3bIYA1JuhR9S/BI/VbkRgSL9qfZLhQ1UoZzAZGIgBRa87XnEkjqQvYm7MDmoDBY7pc6yjq6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756046; c=relaxed/simple;
	bh=HYdIMYSh1158MqmXe9QG/T1T4lEROv0iWYtBR6Omkig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rH6bljKnhFYL1MqZyjEc4rf677DqBKwmJO6AYCKnoJ89lpb0HgKwtSLHNAn4H6xpfF5tKTWfoAh2ovocPeOxOfBGLaSuRrLXaGJTFbejxZHjRWUSytKz0p+WaK3iRWKj+dnC0bXIzUqt6BEEvhRFbREzAclFF+KKibiIZpHJyfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Pk98e29E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso28058055e9.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 00:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1736756043; x=1737360843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCaJ2dYG5BpjFC82sztkfkeGdgCISOUW+HgqGvSX84Q=;
        b=Pk98e29EPLtcHKL9j/bDPwtTnUIHTHU9DinjijFLkzioQ1RqhezbXgu62h5ct/ID65
         3dVV/I1r7RPsLeV/qETChTgw/SYmWTHb3Dlf2G2wbsq6TiTYMt6lMOmagXtKlPYyiGi4
         hLx6tT2QBG/9SGE+KdKsZ5uUOg2rao8kyreQAMLpHumJNGFSrIWjWkhjoH+H2/XJZ0Dm
         Y3oP6TVZcq/6icCVGRoin3s1ZnohhzgT9TXowwryfLtRhKwlkiYF0UOX2vV1Fz4HSuMw
         34ddFRgBnlHcHOsTOQhAKReEyl4yHHES9ztvtZZ7rwFj/CzUuyswFepJ82n75lK5AgJJ
         XYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736756043; x=1737360843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCaJ2dYG5BpjFC82sztkfkeGdgCISOUW+HgqGvSX84Q=;
        b=l6m6zSjOywYJqpIqn/dpoG9yRO8lfjh15IkfGYbvhgoNkWkqauLSmtbebgiphYy9CQ
         WDIE+hIxrV24/F6ZEXi7wdUglp/13eiGbnieuCuPsAm0sEn98PoOvxn/dMOqi/ev3zN6
         Y/szBYcfMpRmC9Mu1eG8vMDmdK0V+bk3cDUnkHZov64k4/EyMpulOM1N/zqwfNL/uj5X
         pVcluLV5+tARkhSYePWJNOMqEgiNuozFxwdwuLsM5n2YezkR+1QdZvhh0zLzaslSJIwo
         HCnKx29F4IOItd8ozAhTK5Pn5LGhlmpTarRt0wudJE1tKIvgvtIW8YDFY78+L9R8FJdE
         TemQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfm2eOVEPeSPnduoHegzv73SRq64vic0/oYBeSpbWaDgRgIFFfZNfmnSj4h41F/+2vqF3OcWJj+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXqd9odIA1m/s4/OTK+I9/cGCMdPRCyQlonVmjeiRRsZ+oMax9
	MoZjJR0vrbOIC2JNc4oa85xmELzsTjPs91OQkHX2w0FgVpBfvQjsnxJfQWiWXUE=
X-Gm-Gg: ASbGncscgI2dXvAAVFFo1cFLEyuFJSzNOT2AF8BAR8YNQPnA5f2fug3kPJN/qDoZP90
	JGbxiAeVeMjMQgm/DbWl3G4twghmZSczt4hI7fi0zfT7EOVEXn76JHfWj9pQhImR7QKL9eDutfI
	VYxHTOtKV88hcBuFg9Xslw4tgoZPgW0ApuR5L8YPmqKCv84y1kiud7XDJBN6R47sfErjrDMKNnv
	Y9cK848bu1UXh3POMF0NkjTGORyoLik0hUD3xHui5iFj6TlpsbUQ5PY
X-Google-Smtp-Source: AGHT+IG9PCE+fsI4rBB9yaSUpdsxQK/6X1jdFrLc057DeHUzJu4sy6EYyKH/l34Yf+7xj7UaM/zFzw==
X-Received: by 2002:a05:600c:4713:b0:434:ff08:202b with SMTP id 5b1f17b1804b1-436e26970bcmr182177885e9.12.1736756042864;
        Mon, 13 Jan 2025 00:14:02 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ac68:7df4:2dfd:e8d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc67sm136575745e9.8.2025.01.13.00.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 00:14:02 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: sequencing: qcom-wcn: explain why we need the WLAN_EN GPIO hack
Date: Mon, 13 Jan 2025 09:14:01 +0100
Message-ID: <173675603573.10811.7947138895685941865.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250102121530.26993-1-brgl@bgdev.pl>
References: <20250102121530.26993-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 02 Jan 2025 13:15:30 +0100, Bartosz Golaszewski wrote:
> With the recent rework of the PCI power control code, the workaround for
> the wlan-enable GPIO - where we don't set a default (low) state in the
> power sequencing driver, but instead request the pin as-is - should no
> longer be needed but some platforms still fail to probe the WLAN
> controller. This is caused by the Qcom PCIe controller and needs a
> workaround in the controller driver so add a FIXME to eventually remove
> the hack from this driver once this is done.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: explain why we need the WLAN_EN GPIO hack
      commit: 29da3e8748f97dcf01498b00d42a3e7574ece80b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

