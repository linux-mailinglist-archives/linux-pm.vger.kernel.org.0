Return-Path: <linux-pm+bounces-20787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD3A18C70
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 07:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1414A18803EE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 06:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBEC1B87D1;
	Wed, 22 Jan 2025 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAaO/DVT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1E1B424F
	for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2025 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737529119; cv=none; b=ImBJGhDmEVntKyrYVG0B5Gksq219T4L1sJ7u5YbiZW+3pB2g2MXuamYCmw7TpKiKWMxCZ2Vclxc+rXm7782ymj1r2ZxMHLN4PdO0wOCL0HqmwGDSopFB4YPsM/mXB5Kk/U+h/obaoz41MPfHnluag4XeR15PXcEHfcC79jGbKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737529119; c=relaxed/simple;
	bh=9oSExSdoybPi+Uw9osvbFjCTKI2I/ihwNaxi67HaoBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNAFGNYprQXbqao0J1ElfT9vo3G3wv9LRq+AFJfRRF64jw/Ca0ZNEWRZkA1SKH32caBPSXypXqUtA27usJORRfedEyv5hid0Xer+/vKo5KFI3cRMjto/gOl7MlIO3jAFE7IZGICOfHWnwtmEaWLxeArPHC6Wbwgj63bHde9gI4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bAaO/DVT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21636268e43so143578535ad.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 22:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737529117; x=1738133917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98nwCRYv2SeYsyOZNSoNm6lFlX/EwFYW68/vkffV1uA=;
        b=bAaO/DVTNOWNYGUUmNgOq0nEU8mDdv4D6wyhRLjfKaA0D19ZNnBthCl+fpfVF6rGlZ
         D0B7LHW3IvwR37R1fifXG/tWHLEwqcou941pjUCOcy17P+/7LQjwiQQssXhET4zA9GId
         cTDMjrdBx+9xJgb0QFk2Ovn7TbaVZ3PqPoMO9HeJHr2PgYoA1tv13KI3aHYnHSXSiTmm
         pKH6mup9NNe3AuTSS2JWJG0rjVpl7zWvS7lIe5hddub5ct3Nx7MyApPES6nyvxlBWVMz
         TxaCxBBcEM+nzK/kftP+BWnasLrHgnLrPgljB2w/maULEJ6mbnvY6sx+rOU9dN1kWyl+
         9SpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737529117; x=1738133917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98nwCRYv2SeYsyOZNSoNm6lFlX/EwFYW68/vkffV1uA=;
        b=bwwE5R7PcalZGw88haxBzuWL/E8k3+HJI3JwGaE73H1pgst77SpJ3Cm4hM7KYwB2uU
         dOnm/d48asLrYD37Sp5KvOiSmWstHxML6QdmihMlKprwaTXxIr76kry7VgVe9wkeMPQl
         DUfylXoHXfjJin1HnZtLjENlKyXixbxSDkz5O/6PlEupwhzvwM1YhCS23jkfLyXMaxHS
         6+YnZdIB7lyUz56LODqAFZlIEvea9w6G5/IBB8xB/sKd3LSRoTpPPLJ9WawTnBOuEhe+
         haRO+zCFkp/2WmwGNvfayAZwcY2s/ILe7L6f973eHu3WdR2Rjom2pfJi8z87jtNe/+Ut
         PkRg==
X-Forwarded-Encrypted: i=1; AJvYcCVS/HXpp5Hk4rsuPA1j9fyP4YV7omGq81gKSxa36VgBRamizUtRaIjtyJMPoMruE9kpV1yoMI3gfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGTpfRsm+tLoKhiWvuwKu1mOccWrMQmJtGKenvn9bMCKncOrY
	KTDwVFEzyOBXTsn7eJUC7Q7ZdqncTpT9++MxEocconKIiJoL6X3HTz3cLxU8pVQ=
X-Gm-Gg: ASbGncsNaKRJNcwqikMfhR2XfsA+EyOC8ROBkrIBL4QkzjhQlhsksuqnH04X/DURU8M
	MvHo0uAej1U57AEBXoXZYRRtZZnNDlj/6dpq5FDyxEw8dsg+oHoQknzC9OL2H9FMIN7GqkgRiFD
	FE0+enUbYDr24zI6ePZPImCcIE58zJ57X36KBdvcn0K1HeCwJXWcW65fwPUhPs5mbzqOZJxfzRN
	ICg5t4jI1JMTGgWBlU2P8muVuAT3/MGtE29t5fjK+qDxMss/v5PlaOp+M2sS2tet7l1ITex
X-Google-Smtp-Source: AGHT+IFlyQTrbWJ70KA4F7+yV/Afg3zlHDmPMltEFy0yFNqRhEfo+qrlLDzqJAfprSQh6gV4oL8egQ==
X-Received: by 2002:a05:6a20:9144:b0:1e1:a9dd:5a58 with SMTP id adf61e73a8af0-1eb215ec11cmr37960260637.30.1737529117262;
        Tue, 21 Jan 2025 22:58:37 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9b9b1esm10519029b3a.99.2025.01.21.22.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 22:58:36 -0800 (PST)
Date: Wed, 22 Jan 2025 12:28:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s3c64xx: hide unused variable
Message-ID: <20250122065834.c4va6uwjrfny2mfv@vireshk-i7>
References: <20250122065216.1371158-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122065216.1371158-1-arnd@kernel.org>

On 22-01-25, 07:52, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A previous compiler warning fix extended an #ifdef block, but that
> led to another warning in some builds:
> 
> drivers/cpufreq/s3c64xx-cpufreq.c:27:28: error: 's3c64xx_dvfs_table' defined but not used [-Werror=unused-variable]
>    27 | static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
> 
> Add yet another #ifdef check around that variable.
> 
> Fixes: 76b218721e5f ("cpufreq: s3c64xx: Fix compilation warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I too have sent a fix this morning:
236b227e929e5adc04d1e9e7af6845a46c8e9432.1737525916.git.viresh.kumar@linaro.org

> I wonder if the driver should instead depend on CONFIG_REGULATOR
> and drop the #ifdef checks.

The way CONFIG_REGULATOR is used in the driver, it seems like it can
be used without regulators too. The initial commit also confirms this.

commit b3748ddd80569ec753f62e709629b8c639143222
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Mon Jun 15 11:23:20 2009 +0100

    [ARM] S3C64XX: Initial support for DVFS

    This patch provides initial support for CPU frequency scaling on the
    Samsung S3C ARM processors. Currently only S3C6410 processors are
    supported, though addition of another data table with supported clock
    rates should be sufficient to enable support for further CPUs.

    Use the regulator framework to provide optional support for DVFS in
    the S3C cpufreq driver. When a software controllable regulator is
    configured the driver will use it to lower the supply voltage when
    running at a lower frequency, giving improved power savings.

    When regulator support is disabled or no regulator can be obtained
    for VDDARM the driver will fall back to scaling only the frequency.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>

-- 
viresh

