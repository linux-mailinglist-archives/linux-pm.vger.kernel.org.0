Return-Path: <linux-pm+bounces-4821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71108877AC2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 06:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB321C2135D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 05:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B11B647;
	Mon, 11 Mar 2024 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMRGqWdV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FCD747F
	for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710136148; cv=none; b=q7T/ggd3S9hIrgQwlvnG8+JzugXvsGdDm1eeIalpNaSNRz43vGp74OKA/p3DEQrWAj7pb+/L/E3duGurdjyf2Y09SBRqcQOqI+bexu0aG7UlFRFvBj/4yVOwPQbyROwvwQL2jFpkxL+UIlyQaLfl3E4a6opEgAJ8FxQLznitJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710136148; c=relaxed/simple;
	bh=iJq8I4665B6tXtRy7Ozf48bVxsc7zHGXEtSdRs+nb6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWWWZIIej8SwxlWzjbwThcdKhdQJ+72Q2ZBvJikjFAr8TrXwgbs957e85D50HKm8MkTScLZ1+fxe5IAQQagnlU+dHOf0ASEWm1miFQSrut0dKUELNkay4j0a4FtykW8dgMfjEYUkiVzTaWOOi7nwK19g2U0eKrz8clQqHdoD460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iMRGqWdV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc8b280155so2974686a34.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Mar 2024 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710136146; x=1710740946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4QvIE9VzTbAgKqsifgCBQZyOLX6yUspxfOa9hY1WXE=;
        b=iMRGqWdVcy0+N1qlpZ2WivZ2VZ3Chl5g3eF1SPHb9+L+kZUDhuR1lfUF6hIfZvDgaf
         /BKCO0YfpLRhvOAGoiCGv1VFtLjoVV5QPhgd+HPoBmn0HlShdxYTPWNV0TwQ/YchbwBv
         rKexnq22fW8CDo0R/o41w9ahPTTY2Razcb/ubJJ0FsDFuiVBlujBjwlHN76FoYySdDwO
         PZghcv32SrOUo++viRCDg3/UwEzBLA451crUPp4Zfq9+iHoA+CZT7WaEOU77vQvznIXN
         +H1TqNN/4GW7uUHsUnXKOjhM1xzyTFr+NGHqI0dGh9mSWuHbrBYG9HdZILrgPGlGzU1p
         SHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710136146; x=1710740946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4QvIE9VzTbAgKqsifgCBQZyOLX6yUspxfOa9hY1WXE=;
        b=mCrcBKB7hCdw8f11/PqlwrK3Uqj+NVd+5/rRcf3xeO9Pm29CqB0rn67lULcFgpLE4R
         mmJgUe1QeOd4OakLCPMON/ysnrfX+ZlVBxxJSay2tE9+M1hPqn9D0oXIvLXbzvZM2rtb
         Xm/ZkFNeMa/bmchwk4hB2C+LMjiVYjJLfU/jDAdaSX42ynho3mEgq3QPvGXU2MakJfQo
         fFSZlVFNxHeoIcCwO1/+U8SgHW3RLLl46oToZ3nazabYbqUIbUX4qApxP2DWyoTiXPTd
         lf9A/VPWv8WN/zMN6Limsl9cF+7uDfZGDFsoXPLrQAt/CUL7YVi7sOxfGYVUmz8kIte/
         jXgg==
X-Forwarded-Encrypted: i=1; AJvYcCUYSTJYk+U+Y81oLis15XDIsAkcw1JlPpyWAx2EXN/N9ELWWLKLAQxGFI5zYp5ct8s9nB5aPbOpPICCMB40+EOz6DMUhUSYvtU=
X-Gm-Message-State: AOJu0YwTwityeSkrStxpOCFnoP6b67GC83eNb8r5/OznRaQBWJBJLlkt
	z6f5F7M8VRxYbDHIPFsSTkXU3mzoRAAqSROr+b3jeA4OO3WghCYQd/EfXJIvWPg=
X-Google-Smtp-Source: AGHT+IGTc9RR/qldDCyHa084mMYBDLDFRMOSdRBDHjzvzzZDmDR9cw7Gtzb+pxkEKOvPNI9IDP9zGg==
X-Received: by 2002:a9d:618f:0:b0:6e4:767d:a085 with SMTP id g15-20020a9d618f000000b006e4767da085mr4576973otk.24.1710136146150;
        Sun, 10 Mar 2024 22:49:06 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id d1-20020a654241000000b005cfb6e7b0c7sm2960190pgq.39.2024.03.10.22.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 22:49:05 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:19:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
	cristian.marussi@arm.com, rafael@kernel.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH V3 1/2] firmware: arm_scmi: Add support for marking
 certain frequencies as boost
Message-ID: <20240311054903.x5khrkseslgyjn2z@vireshk-i7>
References: <20240308104410.385631-1-quic_sibis@quicinc.com>
 <20240308104410.385631-2-quic_sibis@quicinc.com>
 <20240311053554.36j2rq3wgtswwoom@dhruva>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311053554.36j2rq3wgtswwoom@dhruva>

On 11-03-24, 11:05, Dhruva Gole wrote:
> > +		if (freq > sustained_freq)
> > +			data.turbo = true;
> 
> It's simple enough that we can write it as
> data.turbo = (freq > sustained_freq_khz*1000) ? true : false;

Or:

data.turbo = freq > sustained_freq_khz * 1000;

-- 
viresh

