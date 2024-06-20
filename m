Return-Path: <linux-pm+bounces-9680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C0F91095C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D883C2822F5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C21AF68B;
	Thu, 20 Jun 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0P6wIfa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B81AED5D
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896197; cv=none; b=YhQmXz97w5qsKwvw/Xiz4J9WtyhAWaZdpySiQM62iZFOzecWcviUp0nkJm1LwzrA6LlAEu6lRKUbwlkeXFUHCE7SPxqZ6FabxI9lJx69Z0vW/dkUMHarhgzz3uhWiVdzxhlQqaN7xlixZ2w3mnhpkn/NsVTruBmilbsOi0fmY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896197; c=relaxed/simple;
	bh=mfiwSIjC731sExU1owoEvvO8FCSEVIoCYkKggzTldDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7npCpNW42kWP8nsfWeVe1Ah3uV81ONnPKf9juHjlzUV6d4xXo+qSJsp6QQi6Rxm9npKd43wNlUpIEqe2qVPMr5LMKqUgQTKeoBHQF/AhCdgXqkTUqP3nCayyjwlD2WdGLlMKfS4HJgQksCJX6cWxNQ40Dc2+CHrFBAk3HYHgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V0P6wIfa; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cc671f170so1807138e87.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896193; x=1719500993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gK+thIDawbMI8D6X0tNOPUzlxQcTHptuQx1Z2ceRXM=;
        b=V0P6wIfamtHqFfdSKj+7giMe3rhe9Saloyfx06RP4zZ0dxam+nYkdJLhiYR7zFY5Ie
         qkHDnkBjV3Qu+1IxADNrakETXBVYpu+Ynzjiu7SwMfGjctAmni9ecnygedl+kMEgFywP
         p8q42rahO6+xzGYFuQISPWf2Xu4eEEvG2P4HDc7wldGhBPcq13FOI6N/Bg4Xo/zLSu/c
         6o8bBdsxJDeMwGQFzVEnDN9DjIl2ohosU7qsGOnJgIab1pHMWpCL9JKuVcb/TYMSPBvz
         LL6B72fExJ34Jn2uT+YyrqVrdUAXJcS7uLZWnF8jmyOe6+cp2mUO5jWmphIaWC6NX8f+
         VOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896193; x=1719500993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gK+thIDawbMI8D6X0tNOPUzlxQcTHptuQx1Z2ceRXM=;
        b=M8SqlWggoKocF/WHp2X2t8bsiAaeD36JfFsOLzha7ExkfRH+pM9MdCPgtXJdZ7N+Ft
         SQl9TlcinIckUEesK2nVJWKLaJByZX9TY3NR2bawnTm6y8BDuafYKoftHF2sZvbIEabB
         eF1a7cmem8uX9FIwfkv55zEgrH08qDPLCOMXxdp5wlt0th8QLhy7qrxAlZIZPPKBHTFM
         wNi5XaPHqK+b4tU2xWsRKMcyRpgMU0JWkJBwOipB0VUg5zIoOrKGNi3sh0M5iTYzskN2
         bJ+0qO9rBtM5xGySC28H8x7nl+AteWfiMXrXXS0JZ9UG0fC6vFkjifP0+fcKY9X5iOCq
         QNng==
X-Forwarded-Encrypted: i=1; AJvYcCWH4aAKHDeYklNtpkkc+SJSaUCzzlFxOEvOTuLbqdX90+V/R414iC3G2a8yVMxz/yXwtziwowSMOU0UO3HJuTdnVkMqFHvubNY=
X-Gm-Message-State: AOJu0YxNbXS4kD1TZeUphm8L4PERh8Z6wpnpilPtFyxLJ18ZPInxUUou
	uz2MqmerGs3sQFONIQyO/yQtgGrmdg2n2ZUoWRuUIn7HbGo8mECJb/Rruyo+AnA=
X-Google-Smtp-Source: AGHT+IHZ7VSN2wu7ZM55UCXbxtOpvLmg+Rz6tqxnMXIu8tRVtuNvG3de09teEXUPAPTQMcqu6Cz87A==
X-Received: by 2002:a05:6512:31d4:b0:52c:c64e:b902 with SMTP id 2adb3069b0e04-52cca1ea264mr1869080e87.27.1718896193490;
        Thu, 20 Jun 2024 08:09:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2826269sm2091191e87.61.2024.06.20.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:09:53 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:09:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	quic_rjendra@quicinc.com, luca@z3ntu.xyz, abel.vesa@linaro.org, quic_rohiagar@quicinc.com, 
	danila@jiaxyga.com, otto.pflueger@abscue.de, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v1 3/7] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <jfh2xygjdoapkno2jrt6w7thlylgyp2tk7oaczundhxvi26qel@ahtskgn4v6sp>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
 <20240620081427.2860066-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620081427.2860066-4-quic_varada@quicinc.com>

On Thu, Jun 20, 2024 at 01:44:23PM GMT, Varadarajan Narayanan wrote:
> Add the APC power domain definitions used in IPQ9574.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>

The order of the S-o-B's is wrong. Who is the actual author of the
patch?

> ---
>  drivers/pmdomain/qcom/rpmpd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 


-- 
With best wishes
Dmitry

