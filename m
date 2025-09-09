Return-Path: <linux-pm+bounces-34276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EF1B4FF87
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 16:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F307A3960
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9E734AAED;
	Tue,  9 Sep 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTAcSIlF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7C322DBD;
	Tue,  9 Sep 2025 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428496; cv=none; b=u5ia+tOtrISTeFXmsfNg9zvS+WjRg3+E4tp9opLjLrVXx9jRJdwiHwGSvLR0h9wKdQ/6yXmsvnCo+SHQzhE7S4xlW3b2eCNBwn0uz1jHEr4c1+5kRyKxe0kzt6w1DJD4jjKeKqQOtWxfGZsi7+bSVJwtSE6X0cx3VWcutF/Zjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428496; c=relaxed/simple;
	bh=GiVIbpaX8rrEcgYdm96ysaMs+dQh7eC9dHOO+IlMA8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNS7ot8Y/NZ0l6zKKORzBoV4NFac1891QO8nWBKfnqkgbrEtnsfggi6szQDTJZkkfJV5J0LK0SbVUNaV38C7WqtpLgNTkHzuVyC0Hgo0UxlDWutp4Gmrd/09SrJcWr4ePmrWgDlFW3i3MSo9iB3crNxavgvOW4ROJTq049FXRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTAcSIlF; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5679dbcf9d8so845628e87.0;
        Tue, 09 Sep 2025 07:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757428493; x=1758033293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VbuaXeNkGwQa+h8NzoCuHlvm6G8MYoOuPmg2q0e83yc=;
        b=gTAcSIlFqVIYvQtVnXuFYPElDflHT9UzYm83mM5iE5XwLkDNk7fT6i/lwIUDOIDa+e
         hbzioqoWWrxE6DUBYBX/zo8NdlH4cbuDkWzyY2JYAsmzZTvIBSS90mAE8fdhEtsw46lc
         whR0pWzonDnnAGz0hpOn/9ta/W0lN84l4CFDa8mUmGGGMTQGHE6mPK1aia5qAUeqvAeh
         /jMNa+wyokHqgwAmnUYxNtu6uMyGn6SwBzzuZRkF1oT4vr4YPHmXi32lN5Z3ncHeaaRC
         5az6vMQ1blxgG0mpqXZfaV9cgbHgaxCcbqm8c/LPhtvn0G203GP3vfruoM6+6iPYq9px
         Qekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428493; x=1758033293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbuaXeNkGwQa+h8NzoCuHlvm6G8MYoOuPmg2q0e83yc=;
        b=J0aUNULl05NmXGeqq12uSb7xR81GDa6UZ0wli4m2eRD5639yELl+66MzKXnLylajNJ
         rsYjpLZK8IdN7yW2KrvX6I459QuWNu5TvH+wnu5xpHnjrqCwAy2xpGY+CEh8APtFZkHW
         1QoiQHc177sMCvV7Jx8hiTDZkWlGKN3d8AGMnFlCtMjvovD9EWkl99S3oa2HS+w5gBNC
         g8QbQWdM8uoMrMPgeXIAGvo6LejSK3CKRIU/42fj1ioYNX/C5y28QPWPojPwKGve3m6b
         8hU8pvKLqA8zL33t1/LqOZl1sF+RlnbHFPzs3X+Fi7gUj0Do0jayDxALqF4ONNzIgNJw
         rmuA==
X-Forwarded-Encrypted: i=1; AJvYcCVzoO1OPlLjl6rx2mt1JZHr0EdeZYtXU/L37HGOkZUMUI8jyIvWh115rX4GowtE5LsBzzDUgceB64cSxepq@vger.kernel.org, AJvYcCXA+7CEa5hD8WhfbIHwqo3z/M8Yi7InJhGrUpAyO6dWPN40TDeft8VUux7hcAGTW7OdCdqY+iuY4/Yl@vger.kernel.org
X-Gm-Message-State: AOJu0YyQDmEYJKInfNgp4GG8oNoO7Q2MnoBjFRYsIApZsMsiDf3NsD0D
	TEcgveEj9qXHZ2vOUJdYmv0+7SUZRagJVD9sXMNhnMv+vRuTUHnsT+eM
X-Gm-Gg: ASbGncuKMyokdcPSjrF342nxpbC+cV5Wwu6+sk7QqUkCNxYBOaEweYbHRl4oK251F97
	5pVrvJRn4GhsgTvd9Mj4JM1i6xCz3W4HMsHohwCe452i1weTYb8O/cX28ILDpy7Ks5y58v7Agep
	AOGK34nOe24IfFYagx2aoLuVW7djCbHhB7ocDCxDqYf0zVw6Bu+hmlwxbeJNzNBbXrf7ytkR/nv
	c1ANc34HA0xBXgfdA/9s/0T1lce115L4sJ04TlDpivykeoS3t7K+79j+rr3ED2HBltL8mWKtdvz
	bAGYdZi0AoJ6/eGapF1p5Ilr7aulcjnWRgVNgFbj1HINjtrGM98PYdmQkcSIKExqgdAAlngpRnI
	pInZ8bYaTyJYSDg==
X-Google-Smtp-Source: AGHT+IElf0HtryMtRvfQW8UHZGgXa3yk96abG2SQfqxBMM6P6MM9P8reG7tyc0Ev6ID7pDQXbdKXkg==
X-Received: by 2002:a05:6512:2346:b0:55f:4fac:3f2b with SMTP id 2adb3069b0e04-5625ee79cb9mr4815371e87.5.1757428492616;
        Tue, 09 Sep 2025 07:34:52 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56818bfc96esm548136e87.132.2025.09.09.07.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:34:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] dt-bindings: power: supply: bq27xxx: document optional interrupt
Date: Tue,  9 Sep 2025 17:34:31 +0300
Message-ID: <20250909143432.121323-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document an optional interrupt found in some controllers of BQ27xxx
series. The pin to which the interrupt is connected is called SOC_INT or
GPOUT.

Svyatoslav Ryhel (1):
  dt-bindings: power: supply: bq27xxx: document optional interrupt

 .../bindings/power/supply/bq27xxx.yaml        | 37 +++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

-- 
2.48.1


