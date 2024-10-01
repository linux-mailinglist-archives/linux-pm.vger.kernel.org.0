Return-Path: <linux-pm+bounces-15020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8727498BB0C
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91B11C23254
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2024 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76FE1BFDFE;
	Tue,  1 Oct 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnDnFXnA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450911BFDFC;
	Tue,  1 Oct 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782174; cv=none; b=H680YClTPkntDwkSYJ0SQfTbRiPRYFjqXKkofg6bSq9zn+xvi5TYtxHZK4Q0wYtKwa1xSUkuykRPy36k/ddSUjdKx8MDZDBwmDITsiYTj9hDCd0KsHx7v2q8sClipK2yPi6m8EQiV7dMQaBRvYCNs0IgRVzPKGgPbl2JH91GkYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782174; c=relaxed/simple;
	bh=RP5z97bxtOJeAgpUU4LOcGIrbuWscZVuJC6NAITk2b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSVvHprQkLoEslyQoOpLfBkHmXAm/C9CbuB1zDP+Rfyv8zh+nHZXf0n5D2bmtGK8dfAELS01sV1CWWL0vLcanJJYIpig6zXHRiYYdfIgH8n16Ev5OAqRA3PLgPpWKSXg+XW0YTb4LTP8VzIKZanDzWL9y8mrK9mgJLsulTU9E2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnDnFXnA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so2939066a12.0;
        Tue, 01 Oct 2024 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727782172; x=1728386972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+zumBVEP0laJUcfNBZCDRnBbAOT14xK/DuTVfooXis=;
        b=VnDnFXnAc4uluKhhjAnqF2kY+iazKx2K1Z+yJ6WY00JHjtmAbNDjaLW23JF7JdQKTb
         x3sT6E1qIgsFZYqBEKJ0ut9VCTgGrDvFChntkRdtk/7T0dazX/cqeLhJrEGxaS8kUk8E
         1WPF93foF7STgxFyIFVmff0D+C8uGgIl5ceX+TxyYN/QTxfL5xaLu9N0vTGw7XJOQAEb
         HmykQ7Q8vskeyHNpTF+klGBHxTbx+VcrqVhIYNSFmOVBHKkCC6eMOvl4eAsyTX9UfbcD
         pL+lHvdjQRRIJU16y000LPSNFEe8J7qoqBjy+ZXOlFtl3zLfUUYoif3YO4+8ODq48AED
         Vhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782172; x=1728386972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+zumBVEP0laJUcfNBZCDRnBbAOT14xK/DuTVfooXis=;
        b=F1o8kJEXTeUFB49tS++5NR2mTLva92xz2td1iQNxrdEJHK5MiYvjBCuRy1sOk3aCyf
         f+HQvLBqMpRPyv8KT6HBsniEAPc+tdeZBxByCdL5KIDZXvuXR+dDq4W0MHGRf7SoeSXR
         oIyiQa0drlyJ9quvnK3Wnr5ERUONodWIJbr8eW9YWSGLojYqCaGgCXqNTak6vyqdMWdo
         wq9sGRmhIt0dUGN5Ou3slYaeMNzkDQbbJIgyuB0mC7AQbL6puKMcmqKk/pEvnECzZ5uV
         JeO36xD8Tj0cLtF1rTnhQo81zbnIjUwOSzqtNGqg5wo42CalywakMy4LEYUeVwnlLgWP
         GLxw==
X-Forwarded-Encrypted: i=1; AJvYcCWvGGRG3ut36mTSYSTVUOJdJpR29N5J9JFCq512erOED/cKGPIqlr/g0e5uF2fGAw8kt5NhG1aq6mlVLp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzylNSw7ZMVByMEn9qtNZPUl2eOqYvMXGKqFJsMkI49qXsinpig
	+t3WnXjDV05U4Gc/MPbij3jOKtSJMhyLm7oJ464duUjErKZpt6rd
X-Google-Smtp-Source: AGHT+IEg20fpFvjzIS4eZSj3C0EAh4/RK1PCDdSpTJCqX8kep0kNGpwLKVC8cTJWDmjkMM5FyPwzgg==
X-Received: by 2002:a05:6a20:4893:b0:1d2:e90a:f4aa with SMTP id adf61e73a8af0-1d52d10a424mr3189433637.13.1727782172344;
        Tue, 01 Oct 2024 04:29:32 -0700 (PDT)
Received: from fedora.. ([106.219.166.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bae45sm7825357b3a.59.2024.10.01.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:29:31 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: viresh.kumar@linaro.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: mediatek: Fix resource leaks on mtk_cpu_create_freq_table() failure
Date: Tue,  1 Oct 2024 16:58:39 +0530
Message-ID: <20241001112908.6863-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001053906.mkhld5ufrmpdhfud@vireshk-i7>
References: <20241001053906.mkhld5ufrmpdhfud@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Since this driver already uses devm_* APIs, what about using them
> instead ?

Since ioremap was called that's why I added a goto statement to handle
the cleanup.
In this file, devm_kzalloc and devm_regulator_get are called. Do I need 
to call this devm_platform_ioremap_resource instead of ioremap if devm_* 
api need to be used?

Regards,
Riyan Dhiman

