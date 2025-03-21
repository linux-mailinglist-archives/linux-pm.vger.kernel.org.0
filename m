Return-Path: <linux-pm+bounces-24376-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86038A6BD07
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342D33B4C5E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3BA1CDFD4;
	Fri, 21 Mar 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwn0JX1z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A815530C
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567646; cv=none; b=nWcZcbEkoe89F661JNdszJH+SaqWmZFSaa/JK8jPjvf4kg9RTRO3NorllllmWUMy39gXy0GYFX/BMz4gOM7MfCo77auD7WDcQxL/GicFwSwtfduLAPd2vKUThEWfMDVnhNMR37dXD+9fg9GtIS3OKyQh6v3Qo0ko1d7jmGQoBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567646; c=relaxed/simple;
	bh=EqIPwfTYPPoQxL5MLxtRVL0jHROodvx6q7fDZTLOKSI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rQlFoazOdCGkL91Ai5aP3Jb4kcao+kPlJQktaQ7ekpRYmKhH01vzDNPOFYhg4nQoiW9XSOLosrl1AWqHwrNqW5fEFurdRHbjMJKqfqcqt2btR6Ay7JMqyCNcAteU4EwuF9Y06PWcTPxyI4HEGwiQB65qqKH7mynPppiUXlUvS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pwn0JX1z; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913d45a148so1708230f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2025 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567643; x=1743172443; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbQNjrgeARyR0EHQsfXA9zl775aTD+T4eCDtqm9UkOw=;
        b=pwn0JX1zZ6tJcFmWrgAxt2+ODRt6gHz0eAyKEs+kXbGr4zwO1pcDKSkPnoz282Iazn
         ETEMmT84hpUuuXfbzwM5XQcrhUWOUVkwH5vB6P2YJ/pnVbBMX4KnItdMMFsz6iJXfOvA
         KH3ywksgs322RU8ZBGoPF/tmGilO0aiR1CoqrbhrJCPT2tLOQN0RdtpxaPZS2cIr7s9N
         bMwc23mB3TrUOzryjMHKiSgMJb94k5XYVua8KDDjUJ+GTGVhXQLMe0gFcKnldHn1bkYs
         1u4ObTZABn+YeUhrxms4RdyRsMJ18orKUFcAtDO8zJ0CDF3lb/UllUEQzL7oojZYAxlG
         2tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567643; x=1743172443;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbQNjrgeARyR0EHQsfXA9zl775aTD+T4eCDtqm9UkOw=;
        b=H/IP88h5lF5TZG4SizkBvGUtTK1da33vIo2f9MVrSxJKUzvhqPFKgy0bR1Bxeeudku
         IEjbtMRODwYUUCInv4a95HQWD2zAQ9c8hS8tnNwOn1eizbrcTi6U+56PyLHhEGMMJzEc
         r06H1x7tlk91MQOr7ZixFKy3nS9i3vlHjPJ1R3CjC2awBjesVEFHJmb6Ark0IKXMNpJ9
         v1059cZD9i6my1G/Z4qL/2qayl5cEbKMvo79JaVMlTlTK/ovWDbqoalKQbZKeVmgJsEB
         4UMJE3dgI6rCpO1pa70M+0B1osF/wiTLcbwFUbY81Yv3ui6YA3pp+p0Tl1gg/htC49bQ
         4mOA==
X-Forwarded-Encrypted: i=1; AJvYcCXU83qJUub86Pqcz2WhVLu1KY1ddYo8VPsbqWlYzNw6p406CFksu090e7VOaJ4Qb9LTLorGETq2Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPX31HLt8ODIlYApccjT7cUjF2QwqISy1KtaNPSnaHYlP29ONy
	qhS2dGx41K5YWk8nozDdU+PxbGjK34wlIa7r2lPU8xQWg33J20F7If2uEJo/9efbGkwjE5NFlBe
	+
X-Gm-Gg: ASbGncsRIRYp794ykyWzjs47rBDJkvZINGkwxooLcrrKPmcL8XOU4uVv0Xr7HTaolJU
	eRAEqztvKTYzO73peH9Oz7+/cdbZViBH8CZTDPu15/Lj3ihRrBKWeXT1+JzGMKxjCm09OZpRqOX
	a5y9kFUryrjgGIdBv3VlkVQPBVyO0nILqrouU69PdFdY4pZ6U7OHd5b0SNYG5ioLsJJQDtO6GDv
	akpBBbVz+bU10aPtBxSi/OSlhF6pjPUX0cIvwHdiMDBzQ4JHbUrJ2SKIOWzW7xnpN0xgytsPuI2
	iosgDyaW8L2LUzenSb+4n/gPND8y8VUYtMr1+WAfRU3hcEkygQ==
X-Google-Smtp-Source: AGHT+IHDSdCcZoreBSspjtZNd/pom48SGiQP4YUprqdbqk51uAXoTMnzRnHPLgGT/CuHVCtYcgRaLg==
X-Received: by 2002:a5d:6c6b:0:b0:390:e535:8758 with SMTP id ffacd0b85a97d-3997f8f78b5mr3634459f8f.9.1742567643588;
        Fri, 21 Mar 2025 07:34:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9a3993sm2542245f8f.27.2025.03.21.07.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:34:03 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:34:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 0/2] power: supply: max77705: Fix two static checker issues
Message-ID: <94f55158-1776-4f2f-9296-e307e83d569a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix some error handling and an error code bug.

Dan Carpenter (2):
  power: supply: max77705: Fix workqueue error handling in probe
  power: supply: max77705: Fix error code in max77705_get_health()

 drivers/power/supply/max77705_charger.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.47.2


