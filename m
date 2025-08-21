Return-Path: <linux-pm+bounces-32797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E6BB2F4AD
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCC31897B2F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF3A2DBF5B;
	Thu, 21 Aug 2025 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkQ++P29"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965B19C542
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770200; cv=none; b=MNBG1VFz7XNtNByBBC09o2zKJcqUzOWenVnKnzQX37GP3Y5RprmsgJE8ifdtS6LzS1qhvGIvBzHFFCAnj3YWbmpF2Fyn7NcvI7nN319d1gyoyfn5W60pmodQWsyTEvSe/Lfsiz2+ekz522c/zIkUhg+GLjDRNOS6iYSFSaLO7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770200; c=relaxed/simple;
	bh=o1UwzeJaWw0kVzZcs7AuVVxIFiL6JiO9mw8gh5/NBRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5vFrQCQ9eVWkkAgdBd88tp2OdqIKtfX41NBwLjgGhCoqC8MEh+7ppvqrE9IfT7K35CEatitewAhWgyOKJ5i0b4mWIQWwuxAeT1msxOd1US2/Jfi5HSxA/SlZ0HxfdReANFdrvOdfF4ut5hSG2+mn/W6F1vGdwCEfn48YhRjhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FkQ++P29; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso1036889b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755770197; x=1756374997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VT5ngp3FycPHiD/nyGuyIYkXo9clIL8VxY4Dzxjkou4=;
        b=FkQ++P29gbVDaA0yzR6JLORbp7FpoflNuELP2odHf6rsfmvNcU4+yvt/38Y9pB/3V4
         S+o4p1xQH+A+faZesRtlJs6mr1rc5BCkV5/9vqd7HwsmHveUWWGeTKRVa1afK8QHASsW
         uJfn8zDDIOCRWveyfsJtEBjW3Y/nVjI6qXTqwnaR2ivAIJQzH3Dci1K/O8HOnX746wKG
         l/GLmCgRFsVDnuKInVjdtRqH765dlTvTSkzLjpFTvDnaNCyTZK76huEOZ5iNsBB3VO4e
         V6YUVKGGeg/IwIxveIpJWPo2Htqsl5JGzhyjkIG6czLTbFKvSxGH/gjqKX+vTln+A48B
         lhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755770197; x=1756374997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT5ngp3FycPHiD/nyGuyIYkXo9clIL8VxY4Dzxjkou4=;
        b=jcpKzh3ibBm/vKBJR50iED9fWlj0mtP/nWN3ablLj5t+F8035WGoqlUd28pEFSq5um
         QPI04y8ubgkFKyYACI3zm58nMdfdsdSl9ddNsEB8Ad6J/Oy7yAsYm1pZi0bOPOxtyZKj
         jwoWb5OIj/Yt5p14Xs/xl87Gdf6cioiFpen2OQ30CCSun/fVNk95ex09cVAcEsoSOJSa
         efctXuYf3b7Wk7HaE7wxeT9SCl5VkiVGvPFCpOwPQufxX6+IqwyXSAAfSI++AfnEY/7J
         0CyU7Saimb3qE5cmIOariEyyoaI/bdv8qvAQJT8FElt+BUbd/qre79oPjt5hCT+gh6L5
         ERjA==
X-Forwarded-Encrypted: i=1; AJvYcCWKAT49RpSXvWMgsicMRYAJBsrM3r3MJQb/RTLt0Br/0EPTVXBaaFRqWeLbr9+bvXpyyImiGnsxaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pQ2G6J2HZnHVtQRGAgge28Cs/koUi5OaijZxp8Y/WCcqucDf
	DVVf82E3WYNG2KOQVaycfUeEblZq+0ORhRzWGSZjq8hX3mAXF+3mu40jqgs869UwdT8=
X-Gm-Gg: ASbGncvFB67jPHoSPT8CDKURhJOhl5+HxHd40PujpvX3EhN+Du8uyg+Ca+yzceenbXB
	e2qj26TANU4m1OCzhkkYtxYQ1fZuEV/d9pRhmjTxESLMCaZ/TNlKFWxDLMltl+bdVp9lsYKEn58
	U01cRntSmcu9dl3bRow7HaBtZGnhyT8JICfwG7t2laq6fRQAGfx4ysYDsOUR/O5QhtHAYUQjC6B
	YyuXK+HmERHx8Ej3AAhcYSoK1n4RRCB8AhjIwWz50VREpr2LE9Y4clWjFSebaRKLt7sgXyglrSV
	UpMWeTluO53nDOySHPfmutPlvVAK5ANeJWLKg26FCCfWAaE4tKVMDXFFsU80Nhur1ADeJ0gYIma
	6A6XKwA2gjJUSu9nD5IphCa4z
X-Google-Smtp-Source: AGHT+IE/FTn+NnaNN320n3SqkwO2WSe747XNHv/lnN4XuSlccAH09sc2Fd0+XKr9ZGuYn4L06WhfNA==
X-Received: by 2002:a05:6a20:7d9a:b0:243:78a:82aa with SMTP id adf61e73a8af0-24330ab897bmr2399858637.50.1755770196908;
        Thu, 21 Aug 2025 02:56:36 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fb9bcfsm4363243a12.8.2025.08.21.02.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:56:36 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:26:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: simplify setpolicy/target check in
 driver verification
Message-ID: <20250821095634.t6hfkmfkzjwsy4se@vireshk-i7>
References: <20250821090020.167786-1-zhangzihuan@kylinos.cn>
 <20250821090020.167786-3-zhangzihuan@kylinos.cn>
 <20250821091716.x7y76wfvvez6g7el@vireshk-i7>
 <b72c666e-b286-45b6-92d9-7c6dfe5753eb@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72c666e-b286-45b6-92d9-7c6dfe5753eb@kylinos.cn>

On 21-08-25, 17:45, Zihuan Zhang wrote:
> Do you have any suggestions on how to better test or handle the cases where
> driver registration could fail?

That's what I suggested earlier.

> > I would rather do:
> > 
> > 	(!!driver_data->setpolicy == (driver_data->target_index || driver_data->target))
> 
> The current version of the code is much better and safer.

You can actually do this.. This first converts
`driver_data->setpolicy` to bool and then compares both of them, and
both can't be true or false.

-- 
viresh

