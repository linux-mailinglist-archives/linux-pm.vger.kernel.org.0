Return-Path: <linux-pm+bounces-130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49957F60A7
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 14:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DFB20F33
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FDB25561;
	Thu, 23 Nov 2023 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="1StHSanx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97494D41
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:45:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5098e423ba2so1171238e87.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700747119; x=1701351919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYiFNM71aXrUdzFahhyPP0f3rdCUb0ZEqejFPIXSycE=;
        b=1StHSanxf8LD0gKHpaHz34ukovvIq7eKFWM2OmTil3mXpwxREyJN2PVzfV8qFZ3RR3
         ePcx7jijFBpSbY46tKR3CBSvPsmo2dGR8TzpeNCJT48H3Bx0WsdPWAcwFibXkWr8wuyw
         U71EySm6zD9WCzsEwgah0F3btyZ47hb44xCQrxlHY1AWx/lGgobV9IGtP7q7Cgs+ZdS+
         RynOfwSOLdt+LmtMoEtkhHlTzbDwQ1ve7oTXEcVOBsxeDalcZZ7bX6tGzQmg138b/m8v
         3peb87JsblUzd5KlEqIejYAIZbT9FIUfl/U8ESzpqgcUfdgkIldLuKLM2r3bpk0/b4Nz
         3yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747119; x=1701351919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYiFNM71aXrUdzFahhyPP0f3rdCUb0ZEqejFPIXSycE=;
        b=nyLw+s7KqWJG+HJPNORcHP03o2R0S3hNPtDSAsRj2oNY0PyHYCyZRz5XeirvD7+lIK
         4Y9dlbO1hClR+tlJGJmGclsttZ0f3NDtMII9R5O2UFfpTFNhJUW9nnsxoTOtid7N3wFK
         I2CYbTynyaU1dw39hpCfDquq0/C1f641tuYUeEuBAOU35TM30fZi4ojPPLWeXctjHMBp
         fL7lhVQGZQIk9ZT3JGTyBW7JU3fdOIT8StDMxCbHrR1blXVNKOPA4lqV/vUYyGbCV4/E
         g+nkVcqmd2XMM1IY5ZW1ZVeLBnMMzOrScixDt8dNMTNhoP33NS0ZTzaVPsm0SZBOUqrI
         hmQA==
X-Gm-Message-State: AOJu0Yw01Qc/jy53gDB/k8COKRGfkJj5xm+gXkBz2SD3+LlyuxeMDIq4
	J0sqKmovVPeUv5Mg4+ym8zZUHQ==
X-Google-Smtp-Source: AGHT+IF4+CxtDPrhXBIv5S9T2L8REMdTsIcFXNPJgHND943qu/7UkOunGpim4XJQAZhJGMtymhcFNw==
X-Received: by 2002:ac2:551b:0:b0:507:a229:f53e with SMTP id j27-20020ac2551b000000b00507a229f53emr3462952lfk.24.1700747118781;
        Thu, 23 Nov 2023 05:45:18 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id dm16-20020a0560000bd000b00332cb4697ebsm1734886wrb.55.2023.11.23.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:45:18 -0800 (PST)
Date: Tue, 21 Nov 2023 22:36:45 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v4 0/2] Rework interface between scheduler and schedutil
 governor
Message-ID: <20231121223645.i2ujzcln72tw4gw7@airbuntu>
References: <20231122133904.446032-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122133904.446032-1-vincent.guittot@linaro.org>

On 11/22/23 14:39, Vincent Guittot wrote:
> Following the discussion with Qais [1] about how to handle uclamp
> requirements and after syncing with him, we agreed that I should move
> forward on the patchset to rework the interface between scheduler and
> schedutil governor to provide more information to the latter. Scheduler
> (and EAS in particular) doesn't need anymore to guess estimate which
> headroom the governor wants to apply and will directly ask for the target
> freq. Then the governor directly gets the actual utilization and new
> minimum and maximum boundaries to select this target frequency and
> doesn't have to deal anymore with scheduler internals like uclamp when
> including iowait boost.
> 
> [1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/
> 
> Changes since v3:
> - Fix freq selection with runnable RT

Thanks! Both patches LGTM now.


Cheers

--
Qais Yousef

