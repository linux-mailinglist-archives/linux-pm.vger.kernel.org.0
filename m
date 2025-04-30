Return-Path: <linux-pm+bounces-26470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B56AA51C9
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 18:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E806B9E180E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B115A264636;
	Wed, 30 Apr 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKkIitfA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B832620E4
	for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031126; cv=none; b=sBLmygOtFL+2KwpetLCCFr37Pc0NUHRZh2fdnjeHeHoM1ryKNWqeTEkTmxGBqIGbq5S0XN+3zeCTj+G8uvpYKKbWooNzOuXHU0bZzrT1B9+9OVvzplBw61E/vGNwyNCyOQ5WHCraOlSXF1HnxlMgRpswnNsAALvFlItG+jvfiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031126; c=relaxed/simple;
	bh=a+aS3VH0fFr3wLv+ziZGwPORQcPz6cZRwZ8j2YP4ds0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IskmNphf461kPKUjfmioPoHsUCOPiFL9j4qsjNga0/ZK2JCWjwCr6FWeHfPCs0GaAA0UY7I1W6XybniVnPfpkfC14SvuAKvyWo1Nn1kRB4ZUGW4zBazyfBrgwmkYp1vbsBm53SQI7Y2KstWk85nBg7QNSkF651mb4xZLHI3ue2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CKkIitfA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-440685d6afcso156915e9.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Apr 2025 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746031122; x=1746635922; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ImSfHGGDXmae3/biQUrc2P/URlkNlj76LbgQ/xlJH98=;
        b=CKkIitfADxBdSqGUCWMkOThE1jTrvFSJZuyRABPLGn2aS7dnws+eH3W6XLQ1qG5gjO
         Gr5IYJK5FNFHumMYGdFv0aXyPy5xPczbI/uVN3/YOn1Ea34z0SrhbMqGNnClh/vskurO
         diEbki/F5X/gj6o9T9Kzp6S3+zQsUvSg6gmqWr3P6n7YFddQACB8b2UWqSR031MphRGp
         eXVhTEXnGkI4166ayB6JWPH9dtDDBP2b3TyHNJS0Qoyl8T2/8Hfu3zdxRbbYd9XefVwn
         ZMl/pZ9f2W70BukkG0sop+BWefRIs44Ej03vfrk5JjswxqVlIGBJDghrvaM3SiBgNkdk
         kjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746031122; x=1746635922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImSfHGGDXmae3/biQUrc2P/URlkNlj76LbgQ/xlJH98=;
        b=lNqma7Njnd9KgXNb4P/RhTU2+s/Uy8hwpV9giaUNke8+g+V3k6dgsse4KfF37peuTU
         UyhXVUHhvb9Y5Rbp30pTmjJ6XdsuKPIo6e2sS3Cg+ZNN8f9LuXpUp/0HJndDx2a3EZNM
         yjzeXI842fFFDLu2wkGbfH0kQudBZK3O1++8Pq0+BckHqUvwis7c/a41mWcR2KLjqdxF
         cGZ5gEFIR/ts0oTJ+4xRDh2iDkjowvLpPp0Uhf6ICBmRCWx7+2h4ZRq/a2qYvhSM6gdQ
         2MZyzFDN9icAsrC1tzASi6WQ7X+9U/3brbDiWTSl1ttmLRXBb6kwDGKtgFV+x7jjz3Ic
         8s7w==
X-Forwarded-Encrypted: i=1; AJvYcCX0OQwwhYeUKzbF9RpAHuy2qlkbFBpWQsCYsNG6UVW3qs5V26GI5ADozvtH2jeEg43KPfAhrTR64Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4xCagywUGzkYCSi7u9CB9MvDezTBfLQfv+VvAn66FiM9vAWs
	akLAKWRXL6xqIsxut5ERFc1GkGU7r77RPoObMjMlUD/73onSYraiaWLdAeVMHxg=
X-Gm-Gg: ASbGncuzF8SoaYel5xttsxkllqviLKVwpZkxy/s5Xzl6vYuuKzfAcb3YO6METXEgSgY
	ba8/d7HIIqBfmu5cGH+5P/TMoGrBpXB6UAhFW4VDZESfcZhVtvFZbQJmEoomyNPu6wqyS6SF20e
	5+kOV1yWyzIawnLoZzFV1EWaPg5FEgtTHBvkyj1Z8tyq78stHN8OZpfmry7pnaxxUoBgT4kSAuV
	y/3auDxR038og4lf8FF1k+OJS2y0IIp5eFYlDO3NcjzGOH9wd3nTF1nr2FchA3qA/+i3cPLjSKZ
	Y3wuu/COgV4pwZRCrbXprpTYz+ZEvYXCN/0RBrAJSyDJ2fMmagR64W2bCrr8H6DQcxcJoH2+rru
	fwZs=
X-Google-Smtp-Source: AGHT+IEKy3F4uYVmzfjaV7eUGAdjznhecYK7JE8sAsW9F6Cog3MaZ4CfTM6KaWY5hOefQKaGuojVAA==
X-Received: by 2002:a05:600c:1e12:b0:43d:b85:1831 with SMTP id 5b1f17b1804b1-441b25dd779mr37480605e9.0.1746031121822;
        Wed, 30 Apr 2025 09:38:41 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af2a5fsm31756385e9.20.2025.04.30.09.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:38:41 -0700 (PDT)
Date: Wed, 30 Apr 2025 18:38:39 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
	stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 4/5 RESEND] thermal: qcom-spmi-temp-alarm: add support
 for GEN2 rev 2 PMIC peripherals
Message-ID: <aBJSDwZg6Sr7t4bZ@mai.linaro.org>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
 <20250320202408.3940777-5-anjelique.melendez@oss.qualcomm.com>
 <aAI1JnQ2yCjtJL9u@mai.linaro.org>
 <6031624c-9c65-4df8-88db-96800d58c910@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6031624c-9c65-4df8-88db-96800d58c910@oss.qualcomm.com>

On Wed, Apr 23, 2025 at 04:31:18PM -0700, Anjelique Melendez wrote:
> 
> 
> On 4/18/2025 4:19 AM, Daniel Lezcano wrote:
> > On Thu, Mar 20, 2025 at 01:24:07PM -0700, Anjelique Melendez wrote:
> > > Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
> > > revision 2.  This revision utilizes individual temp DAC registers
> > > to set the threshold temperature for over-temperature stages 1,
> > > 2, and 3 instead of a single register to specify a set of
> > > thresholds.
> > 
> > Can you elaborate what are the different stages in the QCom semantic ?
> Stage 1: warning
> Stage 2: system shutdown
> Stage 3: emergency shutdown
> 
> This is the same as was outlined in original driver documentation:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/thermal?h=v5.4.281&id=f1599f9e4cd6f1dd0cad202853fb830854f4e944.
> Will add this info to commit.

Thanks for the pointer and the clarification

> > > Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> > > Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> > > ---
> > >   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 136 ++++++++++++++++++++
> > >   1 file changed, 136 insertions(+)
> > > 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

