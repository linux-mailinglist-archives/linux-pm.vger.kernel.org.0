Return-Path: <linux-pm+bounces-9990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34149176EC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 05:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529ABB225EE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 03:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488CD7404E;
	Wed, 26 Jun 2024 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VcZIjgWY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D328BEF
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719373447; cv=none; b=IGCq2yVVhFgGiBFjkLyStFlXJyA90sYzwW8Tr5HXXEOXeM0ut7DBQTBkeWtPnrDnEm+aYwakQYrctmXgpWfxrGaBhkheIRnMS4FrwZ4TJwfcp0BoFaF56DlJHurCHT4lVmQgSRVc4qVVW+hT1OH8BrNL4q0v4h6O8l5FUGwCMFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719373447; c=relaxed/simple;
	bh=0SjJjNLiXvWHHWkGYpZTta0ReYZBEw9mC09vDvjrwzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrcyszpSNI3YkiZcoynjOsOWOnpt/1d98SdowhYn7ZpMQPIuUsnYglqYNqyHwnH8LiRoJJvwRqUAXdeIJEZDQYDOMMo1jaccTaHib5ydyiu/07mHiYLGH9qGbX3jsuzzJjOsG8vryLJE5bE+kYZIONMPFue0T0WsMUrNKyq0YFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VcZIjgWY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fa2782a8ccso23528125ad.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 20:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719373445; x=1719978245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CiUoVURE8hlT8KKUEtZt5fF9tsezRwum7PdRtss/ASo=;
        b=VcZIjgWYzRRGwtW+rKTUPmyk/iA8VjegKJfNpAZ+/kopCvZZj/PwAyvDHOaWdH+le2
         FyDUdy8PEqTRPebsn0BczCY1/hyID+0xx9IZaBgCKB3Y80heNN3/L+/ZgCiqmzorfHde
         Q88b3rPMGWmKQyYv9K+sKsA/yPEdjFma4oaTMW+T7SbBX9ti4WGFf/UizVSvPT+PD0os
         gXzyYN33EiDjJpo1sJcY7l+7I4djhQ7ikcJW7TrqNTUeSv+Z6MY7qFvwVFTuiNHtd5gn
         YZxGFewd4EsXd8n875ebC77cpU72z4lSGINjNiDQRDyhegfrwyVoDmw3CbiVrjLi3wb2
         fiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719373445; x=1719978245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiUoVURE8hlT8KKUEtZt5fF9tsezRwum7PdRtss/ASo=;
        b=Z6WdWJkD++4yy/9oAyD4XrJEfxF8foWhQwvsvzVrwEqQwCSGmwNEKlVCB0dYGbUPC5
         J1FRg75FOTtNyHBiAxVCD949Yml4IPN0GbQyh5HvaglAdnUij7t06f9j6pf65mTWnjqP
         eB0NMeGiGcbAnUh15aM0fGU9whEVTz1acQadsUBb9toA7RWuZuBsAyeFDXILvwWeuzEb
         SVHxitxYrjxpzlT4S10D9inQ58UlJq9Q4hINCYYBd+v6E91HCkD81zcLkl+lvEnKtXHy
         jI9dMVofR2GMzfyyvkBpLXX3mLcqo8nOGxKBL6BnHBJTHQPlOGYDYqdTuAjM46HGH+VZ
         J9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwPt0CGKjL1XyKi9RtqUTpoAoARhB0olN3PdDf04vTGtBmncUpjTlaKSl6mH0zFvBlHNmEIsWkm8ba3r2WBv3WMBAD5ERwKOk=
X-Gm-Message-State: AOJu0Yw4HLQvP7gJZvU6mJPv89xsJDJn+Q+0f/1WZ8WbWKdetXNZm8SR
	fWMSbEDQTgaGNkYm425VsnbGUomhsgXsaTAirz/Ta86vNIUBd/zfhd6QJzqPNgY=
X-Google-Smtp-Source: AGHT+IGsecOkGJ0LFwPd2/r8OtxJkqFbdn2oCWiBvR/DiBzlTTbTXVg7wZ+vutlRCp4IFIZjlr6Bkw==
X-Received: by 2002:a17:902:c943:b0:1f9:f6e6:5ace with SMTP id d9443c01a7336-1fa23f159cemr107563135ad.48.1719373444794;
        Tue, 25 Jun 2024 20:44:04 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm89095585ad.224.2024.06.25.20.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 20:44:04 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:14:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: perry.yuan@amd.com, gautham.shenoy@amd.com,
	Linux PM <linux-pm@vger.kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dhruva Gole <d-gole@ti.com>, Yipeng Zou <zouyipeng@huawei.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v14 5/5] cpufreq: Only disable boost during cpu online
 when using frequency tables
Message-ID: <20240626034402.vb6d6fkl2mkzadok@vireshk-i7>
References: <20240624213400.67773-6-mario.limonciello@amd.com>
 <20240625063003.cw62yt46b7uaskrp@vireshk-i7>
 <27c030be-d06b-46ab-87d0-2fbfd1dd9e13@amd.com>
 <20240626031142.ytzpyuflgo73piaw@vireshk-i7>
 <056cc207-678f-48ad-bc44-6b3b06bcc5a3@amd.com>
 <20240626031753.dti6ixxi2jlykjqn@vireshk-i7>
 <e8275758-e0f7-46c9-8131-094abe363292@amd.com>
 <20240626032557.5vsjmzyzmtkbzom6@vireshk-i7>
 <20240626032702.fai3hlybfe6czmjd@vireshk-i7>
 <31730330-c0d0-41a0-88e9-6ce2909b6c41@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31730330-c0d0-41a0-88e9-6ce2909b6c41@amd.com>

On 25-06-24, 22:33, Mario Limonciello wrote:
> I can take it all through the amd-pstate tree.

Unless there is a dependency, we try to take the patches through the
PM tree itself as there can be conflicting patches there otherwise.

> I'll put it at the front of the series.
> I think as long as we can get it merged before ~rc6 it should be fine for
> the 6.11 merge window.

Since this is a fix, it may get into 6.10 itself.

-- 
viresh

