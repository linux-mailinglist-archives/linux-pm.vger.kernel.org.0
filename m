Return-Path: <linux-pm+bounces-23780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB8BA59BC0
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 17:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89CB18834D1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80443230BC3;
	Mon, 10 Mar 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbnvJvpZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287E158538;
	Mon, 10 Mar 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625780; cv=none; b=ShQBdjB9/MW4r31sTrRoKU6Ml6ckelkpnItLvgqCKMZD0vdUcUBD3nLRgx3KdIdnrliOdZFZikGqCpqaXs1ZfAqrp1li6/bCYDToFTxpNbVfCqUzTxkFj5Rjd6/RNh17bsvvcP7dLa8hc8/u1bAKgPOroCMqfUs+LXD3/jTHz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625780; c=relaxed/simple;
	bh=Ezrb2dDSxROW84dqyY1v4CU/Kk64AT53I36HDbsTtQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ08ezdM/magf97BPZUswS1Ds/OCYLGfWJwtV+4ZZCYQChb9gx8QWSuKX3w30rpJY6faOYtrz8oHBL+W4dseMY8PZ3fEqfucMIDaBYPHEhptXI1WVZ3aEBL9jWi1EUQMTgQpAaqvQ2xEgQ3AmcA3Rf/d12xr+oWMAotmN0fkunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbnvJvpZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22355618fd9so82303125ad.3;
        Mon, 10 Mar 2025 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741625778; x=1742230578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APYb9FkXg1vRuxJSuYQo7eXa16DnhsCOqDRxqHiUv+k=;
        b=ZbnvJvpZrR/6OyWLVffVa+1G+W+uUjqkFBDzc4RSK8/q5OnQikw1dcQKpCovEt4fXT
         noLpdp3k/4pOz2kt0jJsBkUHTIqVnlsqaVVV6Wgb2Dr28VJbTkiz2O4zToa5yfVgWrUH
         Y2EzbOh4OheaYEGBzR9b+j54DcH5IAdBoW8a+iMWEbdbI4v1Lz8DuIXqiv8g1WVfgJJT
         ihM6OR4DS0T4stqcnZcGFncFgmn9G8KV6/xtcBC+tXbphiCB5q4B0Y0dL2rCIZRe1dW+
         8pw+TAjvy+rah4q1GyJBlQBXGsNolBLRMPQ69wmEP01MGJ25OWBDXU9SzkgDAwrcKwkf
         gSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625778; x=1742230578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APYb9FkXg1vRuxJSuYQo7eXa16DnhsCOqDRxqHiUv+k=;
        b=XB1qIz/UAEgE+WfDXgYJlKUQ1UKPxPUiQWO7Zs1RFRGuYR5Ik24nGxlFEtENXcw7HF
         iE4GvgFXfMf+852PMfJykf7xScqN9KJOKk7AJvbOxXUZrcg7W4MlKkk7CWBzYHw0C9Zy
         s9Ut/ds6L6gpCOJXmervkatLL3QiRFOoko09qR2odKYO3QVwlE2AgYWFS2ZpjI9lWwJw
         ZAc7lhDKIsVoz8ZF2U6dkXU/UU7rm6KENpKMG2g56JI5ZsjX+GavURWbFA5uF0HSay10
         2wCithAzjxeZjB+uTviq4HxC/QSo+qmHwhHfYlg7uU2G/RhSErIJlXXxwEfxQLjMsLEJ
         TjuA==
X-Forwarded-Encrypted: i=1; AJvYcCUJTb9up35aQvuRgA7Xniw1/u9+uiFQERbRlAdwgj9ejtM2YYVaR+1Fnte2ICLRbLJk4/3pERa4BCo=@vger.kernel.org, AJvYcCUVtJ2MykojNbAk5VTUWvKJhI7zRCn1NsnqityaEzJxPtV7tzj2n6pl/KKCgXAj+K+TVj4agg1oIGNMENHZ@vger.kernel.org, AJvYcCUurg6P4ucTLcGCIa8q5KZDBlnRufl0kbNZQ4isqT4Y1jb2trUoKWk52/OIXde8jH35TCVz5q4LLWFzsA==@vger.kernel.org, AJvYcCVe3g6DXfsRZVLaXvqKzYh+sM/Ej5V4eXEzItymWyElzMO3BoF3fjFSfBI9nlFr9vbxHWW6LSQh70GYEQ==@vger.kernel.org, AJvYcCXHq5ZhmjDDbF6YNMtOX/JVlUrwBMX5i1BzdCqHAaIvRzgmRwCL3Hi54jV9ZrhaAs/ZYqcWJM83CJMV4Ms=@vger.kernel.org, AJvYcCXYE95uRPwvio9bsJzEHdR7EnGrfuT7v+LcWFSmhd3l20zSlZawvPUBqzIaPEKf/lHF4GQwsXhk6csp@vger.kernel.org, AJvYcCXuYKzrZiE0bQRL+VZ6ItAUlM8T8umWkr9Snh1frX4tIRKWW5LwqPcezp+03+17SiIMZEhtsOng5LTyGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqr+roQoIfhlwJ3SBZELwazs789um9PmJ41r99aqHb+Ribc1gr
	aRl7rG1YsYIdDq0AuTXEUAqVPAA3B0lFv89tFxpMMO8VXcmn1ZHReC90TQ==
X-Gm-Gg: ASbGncurFjlNPQOZs3629vKQ4xJACKuCPRx6T8g/ERO6qqMDVJP27C8XzCGYi8k+coz
	fUHA5OA1UmPZuRPItYR64d9VGJFmeq3DiSgMq6pdeXHju4YbIyg1UpoFM8p2x1ALUqMlIafsaTW
	92uyVEyvTEF3UGcfPcY+3Nu7/Rf2kFeAmnwO6Y8/3tXAekmIh9Nh9oNqc3TvaXWUFAViGyrCWm7
	qfX4/WkyhR3ceoqIZbm9uwMJzfS2j3j5ACmaZg5k2f9I/q/ZbQ8TaYoSwxthfUBsQOp3YeIIoVd
	55hJQN/Rqe+txuqxsX15yk18rK9zFh2XpU4Jmg1nwjT0
X-Google-Smtp-Source: AGHT+IHYlGgo1/vzV4si4Qn81FbyVTTf4l8pjPxaAUEx+//suEtoprSuUAAYpRMpt6VXcEwCFKWneQ==
X-Received: by 2002:a05:6a20:db0c:b0:1f3:4427:74ae with SMTP id adf61e73a8af0-1f58cb46b0amr604930637.25.1741625777842;
        Mon, 10 Mar 2025 09:56:17 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:eb9f:29c2:9ede:46d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28126e09dsm7864964a12.53.2025.03.10.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 09:56:17 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:56:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux@treblig.org
Cc: arnd@arndb.de, lee@kernel.org, sre@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, alexandre.belloni@bootlin.com,
	danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	linus.walleij@linaro.org, brgl@bgdev.pl, tsbogend@alpha.franken.de,
	linux-mips@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] Input: pcf50633-input - Remove
Message-ID: <Z88ZroxO32c0HLV0@google.com>
References: <20250309193612.251929-1-linux@treblig.org>
 <20250309193612.251929-6-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309193612.251929-6-linux@treblig.org>

On Sun, Mar 09, 2025 at 07:36:08PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The pcf50633 was used as part of the OpenMoko devices but
> the support for its main chip was recently removed in:
> commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support")
> 
> See https://lore.kernel.org/all/Z8z236h4B5A6Ki3D@gallifrey/
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please merge with the rest of the changes.

Thanks.

-- 
Dmitry

