Return-Path: <linux-pm+bounces-8988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9003904B84
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 08:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF0E1C2206C
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 06:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EF1168C0D;
	Wed, 12 Jun 2024 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4vdQMR7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A97168C10
	for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2024 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173449; cv=none; b=U+rUyvqwvwplW3F2k+dFQiushahXZx7wr8MqYrbtj8zehqFz1EmsCF7P7OMYG/lLcJ3DTxLw0SRChhpDiDhAsP04YbQ66JCuAzJ6Lhcz5xE46gkf4iExxFpcVMGV8e7c1EdKImwU6Jz3APIdTNr5c0GNe2YEvDdlReZXE+03k2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173449; c=relaxed/simple;
	bh=lkhq4cjoU+wR78ATPynQEfivjyNaE/5Cv79pLJI/qWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuTo+EKuzusktjt43Mhzdr+TA4MBIwpnVOnFgDG0G3gnLlZLLYySb7whDdtgz6751irCXFpIN0hupKiG7wir94vW2etsOisTazb/OsQm+LJm/yiZQEi7InMRPzOjAromUzZX4DOGWEDFKyI5CLm6vUKQWI6DBjd+1/CE+6A/Yh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m4vdQMR7; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2548fe7fdadso809948fac.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2024 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718173447; x=1718778247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8HigS3vsEIa0qF6/umS9YqXDrpCLWqrULTYOhmxkNA=;
        b=m4vdQMR7GSz29fQHS4InnzM5v9aGslbQ3atBrQP5AztWo9TrOwlB45QInGrso5FPhx
         mDb1Pu+Nbbolo8yNFtGJwoRzlcGdudzLYI+W9M4HTW0HSGWg86MzvqccXOKPcBzdu81O
         rNTqzBVpnJajGgjkA6BS2rclUbZE18/VkLY/XZjgTLR1j/OI2mKmUqvr9MkXSY4Bo1zI
         +zVlaH9AqMJovNJiGIey/e/ZnSxI2tE07zE4T1/W+bTFXiEi8ZvpvVSpKtaXdpAEvuXm
         mJ9CE63CfAsrrNntW9TDysh/M68/oWyXLeBLPwD6Q35jo8ehk3aoXN6qTVQIOu+inP41
         CFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718173447; x=1718778247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8HigS3vsEIa0qF6/umS9YqXDrpCLWqrULTYOhmxkNA=;
        b=ocsHraUCLMR2cwK+zU1LVhHd3lJPbwNCSfc+3jWwtLBaqpypkTgInE/62t3gyJatJd
         NDhWNi6MWqIugsUHjgEQUgY+oqlmxurl+997kYqiygjcQ5xvzmlHvIKzAB1pXgUFtyRU
         kxmM19Afe6GLnRW1ElH3cP7I+ORuKkxT5c+eFctnFANGWN0LQPC1MTd4eZ0LF6ljecKZ
         Kgbvti2qLtBBdUw6xMo769dGkIRRikKWQzOoAzTT/IW1p7KnQWHb206eht1NxuylV4ND
         817l6jMKwry6ADmSfuMsOTzcIEe+TSYmlzMfr8MSjpymPMZRaMB83EvO3aEIHyXX9bXv
         gjrw==
X-Forwarded-Encrypted: i=1; AJvYcCUMN+eGqxvEi+V+VJB2c7k0bY1oUDY9kqwKCv1YZl43HM+d9TyCm9GT92LE/Q9fX3zwPiVgJaVDnfMzBqJ4vnsUMIRMhfwODiU=
X-Gm-Message-State: AOJu0YzcE6X3RYc6ucmUzmaLR5PV6wea/XVvS82zEVEe46sNLHUq4hE9
	dHGr7AHKkCvw8Vo7rIcvNNipwUrYZtumZvIWDa6sqfJfkqzcB8UNpM//lZs7kIc=
X-Google-Smtp-Source: AGHT+IFE0YziqfOQg3+u0lY3gPJqsng9jAy/rH24dSTktx6SY7fLPoHtcl3ORoroPmrZVrHgXcCfrA==
X-Received: by 2002:a05:6871:593:b0:254:a753:d1c0 with SMTP id 586e51a60fabf-25514ef95c6mr1230263fac.48.1718173447130;
        Tue, 11 Jun 2024 23:24:07 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e52500c4easm6187784a12.36.2024.06.11.23.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:24:06 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:54:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riwen Lu <luriwen@hotmail.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>, beata.michalska@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, hotran@apm.com,
	Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] cpufreq/cppc: Remove the desired_perf compare when
 set target
Message-ID: <20240612062404.yjfduze4bvgyts6a@vireshk-i7>
References: <20240530061621.36byo5a2iqc6o2az@vireshk-i7>
 <OS3P286MB249076187B3497D1EDD70988B1F32@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
 <20240606090737.z3qenphikjs5ijj4@vireshk-i7>
 <ZmgQ06jtJBPh5wat@arm.com>
 <20240611091049.lrypvvluntf37uff@vireshk-i7>
 <OS3P286MB249073C57E2B5A36F45A02E0B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3P286MB249073C57E2B5A36F45A02E0B1C02@OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM>

On 12-06-24, 10:52, Riwen Lu wrote:
> I think it's no need to remove the "desired_perf" local variable here, the
> code is seems more readable.

There is no need of a temporary variable and I don't think it increases
readability at all. Moreover, same needs to be done in
cppc_cpufreq_fast_switch() too.

-- 
viresh

