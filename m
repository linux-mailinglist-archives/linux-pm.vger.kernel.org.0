Return-Path: <linux-pm+bounces-6887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E388ADE2B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 09:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549671C21A98
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4D45C0C;
	Tue, 23 Apr 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJv4Ppcc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969CE45C04
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856945; cv=none; b=tAoVqmKKTyq724Mv+Dgnp2H1eS/oMxHOWCXklxgpVJ4+8evmXxAyhngQDZyUfcX1WbiJWGbH6rIj+mynwijLKe4TDrJoThtI2oqJINngki/Mfm0QlIdB8/Y6eYAxgkscUcejsBBw7EDHkjCytZP8R+Kb2Lat8ruZVRBY6VFXNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856945; c=relaxed/simple;
	bh=xG4JAgggbzIwtbQrgp5cQbAA+BYHCthqelpG3g6YI4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvB3VCryTmuFMvx+6pyzjWL6UpQQQJFwdqCUE1vW8i6HnqtizeJDkTJPybdOefVZEqaKL7ViKg7376s/Qdj3Iz+XgfNQXEtaCXwX17PtM2A9PF/8A5HuQki9LDsB8Olo8TCQpe2mvMtJ4BZhUrfhZHQN8f3EJFiZX0i8e1xw/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJv4Ppcc; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eb797e10ceso3136704a34.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713856943; x=1714461743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4/YoB5QNhMgFUUqg2UAE1DzTDTXxcFbcb2bKzJdYQE=;
        b=pJv4PpccAbSaS76FHjEsvNWljXuintm6DSkb74PwXX62Jg4vsdBVflZ7vPsLxISNUd
         arZlIzX3D9EYg50Nm79Q+3AXoFB8lq3ZX/XS2XVwssOsaURuTvj8z9hLDoG6r+lMcJo0
         Xob6TyW1N5hIagWgTMn2ZyTvnYXhyh4lVoPK9sEV74ZC8K9ej0jR7cB7boKkG64aAJ1l
         nb/11NHvjSitEq4xh85FweEcDn2t8vA7sRIL+ElBscHFiM3UVIVG8oGO3mVLcsQkIGtC
         YJkP3cfg9lfepZeEbEHdg+j8IGWd3BzPjqEveBMWWqlsRmnq7rWGrmjA1xLywnv2yuH2
         8EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856943; x=1714461743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4/YoB5QNhMgFUUqg2UAE1DzTDTXxcFbcb2bKzJdYQE=;
        b=uMoMSsvMXQ8j7TQuPUuCMfvVXHZzNa9mjuryqjuOOD9pNZHPgGJow9lT1S/FgRwoeE
         4Z0Dmw0BqjlcC1i+II0pf1cbnW6Nn9+hwzMpiz856qUMuI2C2R26JvD8VBua9/NIFhhx
         VdFkjMjS7ODafM9ALhjrDDeUgsi5Z0A4InxiQcCOoIIxzfzJumE2npkkArBR6OAwtTm8
         hUbiCNdaZUigVYQdfXX2E1ldx/XtCPpQF2tGxEwS+xiRuOxdsYJCiVA+Ow8skdAxibEt
         e0iOytxsklKJ7/3LDa10Yy+FPn+SIatymDosLpfKtLKfj8XPSXFpS96s5PiZI6xIKlBa
         bXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbbgqYdh3SQyuulnkPHqe2dZ+iBt5n7N5W+aYYSQPsHJ9WQaBHHlLKZRAUq96E1gYT22qHwRZt7FOWJ6GSzFKKcp5S5NY5Wqg=
X-Gm-Message-State: AOJu0Yzcv6qIu3m3RjjC0R1jb9O6IP34KBpe3gxJAcBHOw9A7CHhryCJ
	IOEE9ixqjBlyGrMDm9u8bW0UynqnQFwLlQHa9krgJkYmGMsbrT0+s42AIJZUago=
X-Google-Smtp-Source: AGHT+IENc2wersPjV+jG0SCLKtH5Uji/VePfmZnmxfyXZ/X66GgFYNF4DqlSWWPDB3bqhRWLvKbNXQ==
X-Received: by 2002:a05:6871:548:b0:233:378c:a06a with SMTP id t8-20020a056871054800b00233378ca06amr16184873oal.22.1713856943435;
        Tue, 23 Apr 2024 00:22:23 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id r84-20020a632b57000000b00601df0a973dsm1997272pgr.48.2024.04.23.00.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:22:22 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:52:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Shivani Gupta <shivani07g@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] cpufreq: ti: Implement scope-based cleanup in
 ti_cpufreq_match_node()
Message-ID: <20240423072220.sx3lrvjtlirmz675@vireshk-i7>
References: <20240423020727.776360-1-shivani07g@gmail.com>
 <aa2bd3b6-7bb9-98ae-b762-6060f828170@inria.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2bd3b6-7bb9-98ae-b762-6060f828170@inria.fr>

On 23-04-24, 09:11, Julia Lawall wrote:
> 
> 
> On Tue, 23 Apr 2024, Shivani Gupta wrote:
> 
> > This patch modifies the ti_cpufreq_match_node() function to utilize the
> > __free() cleanup handler for automatically releasing the device
> > node when it goes out of scope.
> >
> > By moving the declaration to the initialization, the patch ensures that
> > the device node is properly managed throughout the function's scope,
> > thus eliminating the need for manual invocation of of_node_put().
> > This approach reduces the potential for memory leaks.
> 
> The code is fine.  The log message is a bit verbose.  Try to avoid
> referring to the patch.  It's obvious that you are talking about the
> patch.  Try to favor the imperative, so "Modify..." instead of "This patch
> modifies".

Fixed while applying.

-- 
viresh

