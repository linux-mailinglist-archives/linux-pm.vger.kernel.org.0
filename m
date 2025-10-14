Return-Path: <linux-pm+bounces-36035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B20BD7D4E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 09:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C6E189DCDA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B6030DD38;
	Tue, 14 Oct 2025 07:14:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94230AACF
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426071; cv=none; b=hd1E1ZPJxc2NBX/l0EU3IEmrJ4MJBGtul01R2IMEYf5AXHbuW9+YRBa5iqq4SVgXaGdaPQuw+7FOphd6ohGkD6cXqGFCavyQG73zYNCNeK9g5AH6v9uFyVykKNPHp8l7K9U7an7iEskueehLoNUCNrazlQI2lQ2LoK6wFva11ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426071; c=relaxed/simple;
	bh=sSEQUz4N1vC51QgVF/J8wPV6nb8fqvjIzqiU8S/1ebk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YgdrHOTtmKDtj+qnsaLxiCU1BzpzHzJlgWEbwNNnGfesbWdYB6y0rRuWvhLuE4YdBiUfofsVHiNOgC9gOiXBvpytFsYXCCHw7yfnnT4xLcSt/Iz1+Rk2Iwgt6O4bpAqLWFrhxRnanjaUHZN6h5N4niXekkDHykTWCn3O2DL6l6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so3908004a91.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 00:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426069; x=1761030869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdAzSUy8ZgocF90WcjHBW2VOon+JtEmmbYQOKZDMVVk=;
        b=SQA9FygyL8tOK9m7hWTeIy5p0Y+M3b6eOZPbLJK+66PsGGI+lTRPZXUz5/IZXX/aDn
         OIWs4ht+Pu4kLAYzUSW4eNXFaKP85RlPVX2qsCAyqGPlGSlMwtgiOm/LO1MTC0RxtOAH
         0R58DDWIltqitVqIOYH67c5tRrmiJLjYqmJvoXOLTOiQ7gnylNo/JmjN/RxlGMIsNEUT
         pqb8QvnhP7LoWFSOHFe4KgvxpGDGX3S6+jILj6BezBYAhNus0El1gCmh4D/tX0T8/8O8
         gPM7AyOoZd1asqMmAWFf7L6wzn4U9zDPSbUCDk/9WFWbbxxSgnkM5Ue3xvC1jDputp+W
         ePTA==
X-Forwarded-Encrypted: i=1; AJvYcCVe1VI+f54amabQcD9CUUHl2cSw8dPGLe2/w6yjzC0oz8oQd1gcLvPKaZDkgWKlSUcrWZl6mzYydg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOzq0YPGowRZm+YFblHOAt9A8fQQuHDIfyl3Zloo+Ny/wYIDN
	bYYbNm8uJ/Z+Go0zHSEZY4HQnutbKbKxCAqvPg3yIrhoTftUIjvxtOre
X-Gm-Gg: ASbGncvavWcfevs21ubG2d3Q8DvmVun8jj+GAxeLWUTctNq3aJzPSgHFj4OetrH5HRS
	EduR8OcxUDPOujlHY8tXtZM2+F9GTzngbbzIDfwFIfw4af1Ryj3eWYTWhdjXLmeBse/HIKjFX9J
	5F1vrPqSnnL1yiRkHfJC3K7ymP2xoKI9h0w0O+XD+WxCRjO9kUt4VRw2wlmyUSzqBOv0ZDNUwaQ
	8r39VC62R/Rj/PMQGY6QKkCwElmNHx49+Xzo50ipvoZJXMcC15TFJrIcrl5WSZz2i5QYjCSSt5h
	2dYCPffdI6OPIhMPHe/ObafcgzgFXpCfwaKG1KSej/Noh3ZjD9kdhu5OIBdU2xI3GOM7JF6f0VQ
	O7EpFquYsvvzo5hu1YVeQp1HQuOTnD2fVvk92fBY0zSgSZMVcQue0TzutSB59nRqMMRpHh0U+Np
	5yXfdQPmK+bQ==
X-Google-Smtp-Source: AGHT+IHBUJxkuPQvjDi0tp4Ni9gQZbWJEugoilSleeEqEKswyN6LQweepoV6GTvNet5iaQOUSLpvcg==
X-Received: by 2002:a17:90b:38cf:b0:32e:d011:ea0f with SMTP id 98e67ed59e1d1-33b5139fcabmr33135818a91.25.1760426069124;
        Tue, 14 Oct 2025 00:14:29 -0700 (PDT)
Received: from power-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678de09cb3sm11937092a12.18.2025.10.14.00.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:14:28 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v4 0/2] PM: hibernate: make compression threads configurable and support dynamic crc arrays
Date: Tue, 14 Oct 2025 15:14:16 +0800
Message-ID: <cover.1760423687.git.luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is v4 of the series to make hibernate compression/decompression
threads configurable and improve scalability.

Changes since v3:
  * Only patch 2 was updated: When an invalid `cmp_threads` value is provided,
    fall back to the default value (3).

Thanks for your feedback and review!

Xueqin Luo (2):
  PM: hibernate: dynamically allocate crc->unc_len/unc for configurable
    threads
  PM: hibernate: make compression threads configurable

 kernel/power/swap.c | 82 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 18 deletions(-)

-- 
2.43.0


