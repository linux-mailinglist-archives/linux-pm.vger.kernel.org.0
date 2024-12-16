Return-Path: <linux-pm+bounces-19294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1EF9F2D42
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 10:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5F8188AC54
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B34202C37;
	Mon, 16 Dec 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBXk3t29"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E8202C2D
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342436; cv=none; b=XDn+jxe60RkpIg8HXuUrHshQIfZbuJ30rJLc8ZVFiYqUI/RJglkrQpRweLpnYJW9+5IMV344NtOhIZDtGXWro7fioPxOPa9iUqCbNE9Kj1DBnBWq4tTMLM72Lubq384xeGFKkEjofCyiZt9X5Jn3bRqcpm+mntT2kUKuXYkx1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342436; c=relaxed/simple;
	bh=19iOc77d3Ggxe5Rbnf3je/CltOApn7PKClOcHLYSvXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1r/YCapnXJN+J3VKB0QRkDJ9Tb6ZtSY97qIxH/YkJ27DFER5zaKEoO46sphSUwEdkjPZq1pR7RhjqgA9VqDBFpGAPuua47ahHH3I5hXDc/BwY6m8AKunaygCuhFTO6oBe4NPmqr2MXEiFW+H/eiuhsJARp8y5sfEUX7OXggZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yBXk3t29; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e46c6547266so1422119276.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 01:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734342434; x=1734947234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pe83r7EBJNwLbpxEmYOqE9O4vpWE1qwYOlTzzIj1ce0=;
        b=yBXk3t29stKCnwWM+1/3xp1BOw6qt/5hLZKp7bXcfNanD97UCX4bsqjWpIwfLBqwgu
         6UGNt50K6iv/0vvqFSn8eNRPMKeQ8LptUEu51NRnkb0VoqZepXmSuVeinmOR4uCj/+Xt
         Rgg7S5LIu6UkUrn/CeNtgSAlIGHzoMRPCzXjD65xEgpXYHWePuXB6AWerF+/MOC6vL2N
         V1PSKrlYvVOndLSECkG09VCJ6YfNxcTB3EuEM9O3jRyv/BbIEwkTK3jFjgWQ93FTd25D
         139uAY4PflTmG7ysM89eESR+04yPLGNp/33PQOgFilV1QTqPfDDSxttOuOO0/0P6xMop
         IhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342434; x=1734947234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pe83r7EBJNwLbpxEmYOqE9O4vpWE1qwYOlTzzIj1ce0=;
        b=UJK+ud72SuJmsCjXwn9P1NVmkXxaIHxUkYMNUS7SnZy4hYjQNzzz76xOxagJ4GZEKG
         ZTFYhU6mUe30nOE5YBxmDp9I4pfxCvfFXeLKhkiamk017+qofm2OR3IYS09u2AMoaRER
         T5UWoM2TxN7n82yCKbHWMhJUisey64nuiEukglEbEDE3P6dEKwKm3+8pIaS/Ut8iFeh5
         VzD92whM5fwgNrEWYnchd9bhCcGf3WIpqvbHniNp+RilXxkgLpKPAnfmO8EdhwRmd47B
         U9dq8ApUEqvWb9q3JuIrZeLE7zHbMGggZzk+I/+6F/jfbjwqjHRUtHutCIhcsMweDMbt
         Yd3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU68zSamdxOSVR9u0YiD9xvblCoRrAnjD6f8NpUPkX+pmHNuFklWkgIw5hmByZuDUVVDjJYAqPvMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHEEFsk0Mf6GAL6LF8Jj3hpuw+vF4/wUzuqnfzl4J8F7Zk7WZJ
	p6G0g5mSDcey+0WKNlKTCpxwKnBwaqOBPMIvck3PLStBRCQDxEvjt+eCTpnfoEQ37tTvNvmhmUc
	x3PJFlB+GJ0Z74DLcsbHOdYV4i1VgSppUfnKcGA==
X-Gm-Gg: ASbGnctYM6wLi/HWnwvyvSFeeXP+PiTb1uYYVqBr3RjlEX1vQtfHb+uougBoiE8iUgV
	DMGJymWkHkL9g2u5Lclp55R7v6dWs4QlMs+Sau2R6gsrbEfvDlGdp
X-Google-Smtp-Source: AGHT+IHRPs0kD+k0X6sSUYa5phjbHrCCd1shK+RWsI7yxEyO0+bZ0KInAecHsFuw4uGBN8uxjf/k72J1QGR369kOv+M=
X-Received: by 2002:a05:6902:842:b0:e39:8e5f:adab with SMTP id
 3f1490d57ef6-e43508ccebemr9859633276.39.1734342434208; Mon, 16 Dec 2024
 01:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202165723.17292-1-brgl@bgdev.pl>
In-Reply-To: <20241202165723.17292-1-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 11:47:03 +0200
Message-ID: <CAA8EJpreFMAz9wWN1sJWDfm+ijATK72JwTOJ+OjfQTq48d0mDw@mail.gmail.com>
Subject: Re: [PATCH] interconnect: icc-clk: check return values of devm_kasprintf()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 18:57, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> devm_kasprintf() can fail and return NULL, add missing return value
> checks.
>
> Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/interconnect/icc-clk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

