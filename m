Return-Path: <linux-pm+bounces-18094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4009D8B3C
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58874B2E9A3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900DA178378;
	Mon, 25 Nov 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aANan680"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D11B3936;
	Mon, 25 Nov 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554562; cv=none; b=FM9IdrCHUomWID3a3u7GFT3OsQd4DT+L69NjxtEAbxpxOoK7xQ8ZtcM5VbvAnjSGDvna9ivijbC2G927W/fDja/kGE5hBGaowMSSnCwvAULqJFREZ/DyaZO3ziAuLxktqgRQJUSvCPSMNHepWvSgZJWv7NXIakmZXxBWpn0Rd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554562; c=relaxed/simple;
	bh=35e+48rgKSYMduNQYiQzLFwMIpe/wVtCte/IKLHVbS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8togiPFspjJXyW1U8T38Fup15qgFr3FmOttROo4jPgy51KDVODX7vaWkkWM/dQy8yJJ+vtRAG8bkTEPtz/JJjeIuzzToOaTQlaMmiT41LDTVpE/iZuTrBLbFWlVnWLOdKAvQtI4yHw9ZcblDvKF0tclzu7hS1BMlMn5XbUXJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aANan680; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7251abe0e69so416250b3a.0;
        Mon, 25 Nov 2024 09:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732554560; x=1733159360; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1DxcvAD7Jm1OaRKh53w1UpuJB7A+rQ0Cu0gF7bBYHg=;
        b=aANan680Lzoe9+WTnYfeZhzMxlJvZLbBgLEKz8Tt5VV173HGm1A0kVl3bCL4ck9T6K
         fC9+C1tmb8Q5hz8btkktUDBMfhAi58LbotY1E+oLDSwHvNtv30Tv6rQAm2ufT1BFr/WF
         SxJT/pF8N/917yNkPVCRh2ACg/HXCwtpsovVVKCJ+LA3P9V0wrzcITNwAzVl0KKlH9+c
         TEUiUzgq+kMVxA+TAyVbp7rXRzsdekC6JQ02wGBOFCgqIz0kgvzkOXX0TCJXLMhRegT9
         RMbuDApuW5TY2E1oVPXqJgeTpsnGo3YWpbM8lmTL8eJhuaGQL9kkjcmtRhOSNQ63brNi
         9dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554560; x=1733159360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1DxcvAD7Jm1OaRKh53w1UpuJB7A+rQ0Cu0gF7bBYHg=;
        b=QCWZmHFM2XWhcqDJJG3stSMJZYbl2E3h+IJ8DGTCeqSNK9GNCastiKArDcgxrHJAWT
         nPLJeNpRJSIfMWKcLYNXlwRPbIRAMfloSrkIeUIVa6WXm7vFG7CD68Ya0OayFURC0sud
         9b6VfwGEhcK35cUCUsowPDFY+7IsebzHvG8zMIL0G1n9FuXwLLH4zrfORh83uUpZrtIJ
         TePjSxOIt0ASGovQVtn45+ps8V2cAyjakYdmMZ2o8BDA7Z9fgFxHzn7zqlKNf5SZrhdw
         a+RAsqSwjtYKgb3zCyI2wudVsK20Cbcs6kIWbykERAI2m6NcLkJqo9440uE4MVPs7ugx
         c6+g==
X-Forwarded-Encrypted: i=1; AJvYcCU8b7uSyfsycObjwYb+8zJFEUEzjkDpjyY98Thw9E1autjju79gBJQqeh9W8qdSNVwTC+vUWjb5zhg=@vger.kernel.org, AJvYcCURTgt6KKVGF3FpH//ZjHXe7CrJcMazPUxXwgbHTWKfDKTw31SuPcnKyL5DHq3OL4+pTXjECRdI6u+mC5z6@vger.kernel.org, AJvYcCWYQyeCnmyImde3Q3w+N/ZB0XXBRjIqeW1q7JeSh5ssLWjB5QrGY1QNB+bVn+7TVp9YDUwWwrd/wM11Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWsOlrBuZKdath1pYnSFNEKRD7D6eLTapKr7w60nkOdKVhTAG
	nnSYX2ALxQ+LvHNNdrdTTOQon15+3IFBlYBGsPZa49vo4WNsTwNt
X-Gm-Gg: ASbGnct82JyNNxmSKwrhGdgnxaCF/+el0ITI+vTEo8zDjWIn8Jere/5ZAHnd3Y8bsNQ
	LKI7pzqQD69OVaofKDpFnIeUll/3MwWl4kNJz5twcVnWOU3VExRskRSqxxyvo0XVI8UFY+NauGd
	wAda0uPmGpn27XGXqnzne2NLYqb+E/UbQG4qpkpM+DX6MNPihZR14Jw5Vfh8gFuxQvk1LHcCp/9
	i/pPC+2wZom6Vjl/xGLaT9SnIX2wz3b+NbXR8FDMqbMCHGnxbqyCVvTMzP2c2A=
X-Google-Smtp-Source: AGHT+IHhVI2GBloIuCuj/8O/9jmYIoSQGFRksCPWH0LfNqXH0B9QqIqwDtKvF1/0eCF/KyIi69hAog==
X-Received: by 2002:a17:902:ec89:b0:20c:9d79:cf85 with SMTP id d9443c01a7336-2129f2a760amr161819025ad.54.1732554560168;
        Mon, 25 Nov 2024 09:09:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc3517dsm65746165ad.282.2024.11.25.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:09:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Nov 2024 09:09:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] thermal: core: Add stub for
 thermal_zone_device_update()
Message-ID: <43983704-43a8-4849-863d-a287d6f452ed@roeck-us.net>
References: <20241118-hwmon-thermal-v3-0-9c17973e7342@weissschuh.net>
 <20241118-hwmon-thermal-v3-1-9c17973e7342@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118-hwmon-thermal-v3-1-9c17973e7342@weissschuh.net>

On Mon, Nov 18, 2024 at 07:15:58AM +0100, Thomas Weiﬂschuh wrote:
> To simplify the !CONFIG_THERMAL case in the hwmon core,
> add a !CONFIG_THERMAL stub for thermal_zone_device_update().
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Applied.

Thanks,
Guenter

