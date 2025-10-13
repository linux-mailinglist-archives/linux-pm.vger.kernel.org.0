Return-Path: <linux-pm+bounces-36006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B86BD64D2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 22:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 718F14E9D1A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8079C2DE1F0;
	Mon, 13 Oct 2025 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3rf3i6I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7F1D618E
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389020; cv=none; b=EXWC7bRhAm0gecCb6U9Ct0P/cHBkH20QzZ5Vk0X29N4QOgKD30MuW7PtkYBUqSrjSDebOG1zbHkX/bhCy9fZWOKPk2sZ97CtdkJxIPRYIcTGW9/tROKcTD0QK+kJ/BJEVo78XAXPW9rtpawijA9SQYErBM6iPdktdEoIv7ucHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389020; c=relaxed/simple;
	bh=OyHiH88dCYxYwp7WHWkEWZwQO/x9OpCs5mZ4bjKgNEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/cYArmcZXgpx8Q+saMRuKXgRdxaT5tWBIe5lPs7hDDenNy34hOCnov/XJ5N48K4YQ/jiMvSE+fD9GbVdZwZJVUT+oTjwGkqj4+L1H4lM3hI9wN40dh3Iy0VhorOAkzuMIq+269tufO6jD9ITgOqZr7IHMv/Kna4ZI80mNsDRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3rf3i6I; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57a604fecb4so6055947e87.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760389017; x=1760993817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OyHiH88dCYxYwp7WHWkEWZwQO/x9OpCs5mZ4bjKgNEU=;
        b=L3rf3i6I5l+ZQdWbOB85da8qGu01faVP4jmsdhHA1clYPKqIKMiS53LzDjtBOi5Qoy
         nkgpmu95OoEb1qrSI/ro+/QTnPYvU/WLx4jyJSTgnSrXzNj87246ekfqoNR317SXSddr
         +WG6rKn9csIKg2Avdk/4eGYo4w3zVHUXIkFYGTAa3UsZ+AvMhbYw5hbptxPGFnxsxDJC
         9XBpiQWOArfacWwtzAKGZuYty5wbc62JHEapXN5FcqSn/dxaW7t4msm/NAM1TeSOXS7w
         TrsEOogCDtF7gQS/NlkKIT8IgKqlP1aE8ao09qCJxi7XJQ5+43RKpcSXMLGM0hoGFVQd
         A/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760389017; x=1760993817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyHiH88dCYxYwp7WHWkEWZwQO/x9OpCs5mZ4bjKgNEU=;
        b=bOaMV55+6vQ/Fg88SMBbLpMvj7lKDoEehmgp9rpeNGQt009EDNSLZEnXBxnMh0LBWc
         72yRzHw4cHfclHUmPdmstgY9lA4kVAdbu104h6Kal41RmCcMdyS4GEu0xeY88rGFWFh1
         OdVXKRcRHyCU0zbfqjvffq4EJ1ldqGh9sIigMRGKp9mTAU9yJ0x3XAStbBMvoKEAAvfe
         HgVEZQnyMhJ6i2kixrs3gS1W+k/xJ9sY5GylSroPDjaUupgfwiPNm+O8f0HZrDZhrxDN
         R/d/xLSKFXmkYYmV6YrrjlPvd0PM27CggSNY7HTMoCBpWzgcc0GSmCpiY0VRynmHnb8Q
         IyJA==
X-Forwarded-Encrypted: i=1; AJvYcCV7mPtribCbR105tDBf4BAH8c7Ww0E+uOGqwPS3y60R+cbtfWRzpE2ryXjbZCC5gcq9l7CIqtgTKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YweM7hP4V30eL1jvvH3GqjFUYIozuE44FKbYf8pm1iY7c+wcHaK
	IRaiDIo8ixTeyfPwdYfJBBku5gcIc6YRZMJP7FLcVbfnMVE5toR1ay6F4/MPsCnMrK/XPCL3MVl
	9UNSRzZSxS4aBXcKD/tytyGkFKgYEb8XKMJqmsrrt
X-Gm-Gg: ASbGncuN7NfB7mX8SEv2ZcobRmnE7M/rGKm5DvTviQpbt3vpRQdykd07N9BBn7CSlOR
	JGaDLDLBQhc8/HvT8gzH2rikEGMTnnpV1slCOuqSlDqd4A9MCFln5Lq7NrxXuIfsCsEvDhCnqU8
	Dk7MDjIrvFDGbYQmbbcfu4BdVn544NlE0RoQYqFA3LbLfRahIOZ0nbdr8VX4t+0qPrQxkmRutmW
	0V7eOAqaE4OloKpVJ14xRY8P2JDr/FU574Lh9hhf2Kgl2VySVT7z5i55tLdtiA=
X-Google-Smtp-Source: AGHT+IGmVV5lrs8Ti+xvSM/oKnjUH0scqx7Ugbmdv684Hq14+QRlFYGp9dldJN7qQ6cXZcuxuKZ/UbiBuXuT8Q9PGmk=
X-Received: by 2002:a05:6512:114a:b0:57a:640a:11b4 with SMTP id
 2adb3069b0e04-5906dae5760mr6285581e87.39.1760389016204; Mon, 13 Oct 2025
 13:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007000007.3724229-1-jthies@google.com> <20251007000007.3724229-7-jthies@google.com>
 <aOZiuxDfwYql6ZUu@kuha.fi.intel.com>
In-Reply-To: <aOZiuxDfwYql6ZUu@kuha.fi.intel.com>
From: Jameson Thies <jthies@google.com>
Date: Mon, 13 Oct 2025 13:56:42 -0700
X-Gm-Features: AS18NWDnCuURsI5Lz8cXhrSTClImN9qgumfpqgNkVL2-0TdBQW_-2CRK892lf2M
Message-ID: <CAMFSARd8U1RN10pgRXJwn4y64cNetK7isNWHgqrY6HJQn+LLtA@mail.gmail.com>
Subject: Re: [PATCH 6/6] usb: typec: ucsi: pr_swap should check connector_status
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, sebastian.reichel@collabora.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Couldn't you use the helper ucsi_get_connector_status() ?

That work, I'll switch to using the helper here.

> Maybe this could be send separately? It does not seem to be directly
> ucsi psy related.

Sounds good to me. The same issue can happen with DR swaps, so I'll
also update the patch to refresh connector status after sending
SET_UOR.

