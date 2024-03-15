Return-Path: <linux-pm+bounces-4972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CEC87C8A0
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 06:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EAAB21FB5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 05:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A94D52F;
	Fri, 15 Mar 2024 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFCJlLyI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49E1400B
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481858; cv=none; b=cugAZSL1sMhY9rE51A9dfE4IgQU2xpvbxl5s0fZeGIh1U/DFAZg/0saYn9MOeBMvCgFNz1HEQWrsBq+nmqbELOw+f3sBUsdNCXgO+W++KHyCZVVHE9J8wU2iLThtinkWk0+BTalDd3Fk2FUzZaZsC0XyGmJqkvZmow/gtm9i/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481858; c=relaxed/simple;
	bh=YLMCpkGftwnRvP6OHcJwPra4ldTcLEUhhhD1EiB/Hpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9wGf0JtHHa38y0XxQdh4eaCgx+pgFbBM9q3RLs+1LvtmMw3r/E1sAGM7y32jvQUpKXEbnK1ISSVWED+AliV4llDGUQfYys98+u+qWq7idFd9slFqsz2NDQIHKDzGByhwZvANK3uCGDGz95kD91F5NuLAgNqpgHMS/BgGusJu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFCJlLyI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6b54a28ebso1829352b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 22:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710481856; x=1711086656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=doJoUmDIAXOFTyNTaIXiWO8CVSFB4RTU/SEwZDIiXeg=;
        b=fFCJlLyI9y2LbcNd29RzxR/ogw28Z/Y0e1QleKdDYTw9L2ksNU3eOgrPRogFnCnQev
         77M7CQIccKCGKwKZE0KkE9jD2sraUeAYCL5ECTpwbC2NXEIh1H4ilFClgYlnPK3uLYZ5
         jaJ5kcrtBU+qXWjq7Ipc4GRC6jBX7N63XG8IJ3yNSgRRguLp9dBckI0CNWR7VeayaNfu
         G/QjmpAD4vt3BrFVHF63/Gi3ByC2Lxxc5SGm9Uzj5I94oP+KG5LGzEj4jalU4FS9zA/u
         yLTotKm3JPv0yU5d7BHUZjBOZuaws9TaGn8OS2GRniPxljn16dQjQKvU31RfmLNb6By5
         u+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481856; x=1711086656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doJoUmDIAXOFTyNTaIXiWO8CVSFB4RTU/SEwZDIiXeg=;
        b=Mxp3M+lN/ZM4tiuph/+h32aXvAWfJLxKVkG2PTqf9g0/Q58hhvBDjPejiAmmnCIcH7
         e6OMfwbc51HEZ7V6UkUsyNiChHx7XdOR/CXhIcira+P2kkvrQMygZddmAbMCbHSjHgy1
         15K71RiQJvO9P9cWHN6lRu8kR5cQQeKjTJTYRrjbEtjo0Kqn5F46118oP9vMpUcVuA+z
         lk6KlJh0I/zPqKzzhGRc5EgZ+wW8yIoxvblgOBGroySgbYSw+D8dnPD0IlCX3XZB6+YV
         I5W82eL+NPkngun3ii7YWKvhu6sZ6ixX2vnkuhbtFhNOfgsdiQILohNvAUDjSs2pXhbk
         VEOg==
X-Forwarded-Encrypted: i=1; AJvYcCU6+VeGggA9AuO3RKbZNvvdwY5cwpefGTT08DheQHZPMYvtfbwDq+5yQTdlIhj0VufonilYVqVm0TQwQtyJRM2QcpE7G95rbwQ=
X-Gm-Message-State: AOJu0YxinUiG69/+i9nAfwb6ZtH/Ehs4ogD9p+RnlNrfyAjZsy4v43qM
	Z+scOuevqbY5LK1wB5FIMKvtMcbrmVTG7JkFihOD0aSBpaAF1T4mUGtuSfhyaY0=
X-Google-Smtp-Source: AGHT+IF8TBbL8ijQ19uOHux5h2xhr4W6B21SMrX6Qo49YKppD/YPhBVhbmfkzvgyqyFW6yizrp9NlQ==
X-Received: by 2002:a05:6a20:8e02:b0:1a3:13e5:5200 with SMTP id y2-20020a056a208e0200b001a313e55200mr4910274pzj.14.1710481856364;
        Thu, 14 Mar 2024 22:50:56 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id l23-20020a17090a3f1700b0029bce05b7dfsm2166577pjc.32.2024.03.14.22.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:50:55 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:20:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, sboyd@kernel.org, d-gole@ti.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH V4 0/2] cpufreq: scmi: Add boost frequency support
Message-ID: <20240315055054.wbhi7456j4ph7mbn@vireshk-i7>
References: <20240312094726.3438322-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312094726.3438322-1-quic_sibis@quicinc.com>

On 12-03-24, 15:17, Sibi Sankar wrote:
> This series adds provision to mark dynamic opps as turbo capable and adds
> boost frequency support to the scmi cpufreq driver.

Applied. Thanks.

-- 
viresh

