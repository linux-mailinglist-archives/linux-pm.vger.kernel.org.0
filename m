Return-Path: <linux-pm+bounces-36237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12643BE2A99
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 12:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDB7B5059CF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA9332D7C1;
	Thu, 16 Oct 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IvIkSAKq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651232D440
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608845; cv=none; b=duUeDwdjpYUpHr+QVW3/cwLCyZRxEswbNaNfXCzZBs6/iSdO69wENJAfo4pQD3w6VLEYFTgpB/gz12JVtKYgk54QYFtXDWL4yCpaRRzSkRoQAmw2FhykWzXimjgyZ8/9TulOK3w+Dda2c9rpGYA9RijPHExsIE478mxrqh06mDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608845; c=relaxed/simple;
	bh=GuHdpaWnWYFigwpENImVEQ8FLU6LX49o1UO74ZnhrBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAP/JUZ2doDFkzutjfh4ZuUPGCuYhYhlA7dDh4h8LB1Hhxt3wPBTH7o5aLS4kqXG4zmV4iiWbVhXHT62zyfZauR8jtjLM/huPsUAjs7CjVbZCNyGNdQ2472l0x7CC0cj1HUw/525bABjuR+G2L73ovINzPtNnRhN8ybVFTz2P6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IvIkSAKq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eec33b737so8624925ad.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760608843; x=1761213643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzhZSXVDw5HBXWXhpgNz8QGmIpqR91GrblzBsUR2jdE=;
        b=IvIkSAKqs0wrbYgEtNn+G2fPOcEq+fFL8J57V83XpTZ71hxTH0Xy0ur0iZNhpcTIuj
         zeZJUDyLzmaAaEw2jF8pf7RIQ0GtDJSp4l/JPtefL6Gfz+uS7QZBfJazqXCrmA4Iho+D
         9Xm6sNIF4efqGmwI9Ww4ok8op3ivPC2qLzWH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760608843; x=1761213643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzhZSXVDw5HBXWXhpgNz8QGmIpqR91GrblzBsUR2jdE=;
        b=S4lrCrk9NgSAh9DJLrDyaqF2Ws5M9CqbLc9U7oQzw0gIneyvqlNLFWrwPo+zP6GnsM
         tRvaim2EV/puhpVV2/FK/GWbQ2oUbC3xnhw88NKPVky/DAMyflF7GpKdVL5MYp8i+3M8
         kMNI5kEUcrV/fUbexnsKI5oiCU3oUbf9J5+659dEMi+pMU5wwsRSMLVrLV+3i7Ne8qdy
         qgShbwXPecV8RJkJP3Af31L44kIYandiA/j3qqNhWrn2Bs1R7zvA4TTUm/bHD6DEb0dh
         FGQZ45aiVCOTFxkCHH+U1c3pT2o56zov3q6w5yACTHCFE0jsYS8EatePfsErGg+d8VQG
         W0og==
X-Forwarded-Encrypted: i=1; AJvYcCV6v1o7AOZpCGnOfuUF3QESelk6DBHxNUdvnWIwzLreQgqm4C2cqTZFZgIn2wzXX6YLAbRgcEG6uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTFR3CJnhM0+eio1M/WSbsNtWWRs4InxUkxzrIggq5yIn7iPe
	P4I//5KlFE2ifG/TtfNLcdkCSm4gRh7XumIWKy+TEWP2oRd63hPGqemQjAu6bHMaxH8r6qIHYs6
	ixp8=
X-Gm-Gg: ASbGncsTP0EjrVQegNAAUV7n/PH4dCS3m8VXbyGpMCEDu1245ypmJ6K/baah6g4oRrV
	sSP+tcellKhU0s+PLaIRks1hwOzVpq7oox9hozzGlziDejhEc9iABk2QcdHl8G3KSlt1Og1MXY9
	qIdvYz0mlfmrN/7LR8s7S+86EaE38T4aDdTo0uUODKTQltzsj9RRWEaP4uNYYqnOVr+v3P68LIm
	Qbc/yBgMAIobcwYzfNX4sAh0O5pBOdevwFMXq1YhEmVBE4EuxGazcnHXDKIeuL7SGN2bKkd59hH
	K32M3Jlxg8whvcOBz0WzijnZWVlHOnj7X1YrtiTVi5W+4WMdZM/F+epW/YGwgOJhKZyMR+4MHne
	h57k8GA2Iu8JFIIirqznLEj19fneIf5pEpiLJ2QMs91k6Pw7FBfjFxSjvXSXtaYwFmHDkFoN8a4
	sBzOvY7xoBBnBd5A==
X-Google-Smtp-Source: AGHT+IFuKHF70rg9myfkHvvqf8ak7ClXze86hhc+4ZWu7glDGpK14qjiuk/CiRAUD3qVgrKVbYIklQ==
X-Received: by 2002:a17:903:2388:b0:290:94ed:1841 with SMTP id d9443c01a7336-29094ed1a6dmr39122505ad.41.1760608842794;
        Thu, 16 Oct 2025 03:00:42 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:98b0:109e:180c:f908])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934a8e6sm24587115ad.30.2025.10.16.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:00:42 -0700 (PDT)
Date: Thu, 16 Oct 2025 19:00:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Doug Smythies <dsmythies@telus.net>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <ytv4w7uw23fwdkihbgrpegmco6yzkxmzjbakmxtricreou6p6k@rhwxcjq3jvnv>
References: <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
 <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <001601dc3d85$933dd540$b9b97fc0$@telus.net>
 <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
 <001601dc3ddd$a19f9850$e4dec8f0$@telus.net>
 <ewahdjfgiog4onnrd2i4vg4ucbrchesrkksrqqpr7apyy6b76p@uznmxhbcwctw>
 <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com>

On (25/10/16 11:48), Rafael J. Wysocki wrote:
> All right, let's see what RAPL on that system has to say.
> 
> Please send the output of "grep .
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_*"

/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_max_power_uw:6000000
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_name:long_term
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw:6000000
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_time_window_us:27983872
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_max_power_uw:0
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_name:short_term
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_power_limit_uw:12000000
/sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_time_window_us:976

