Return-Path: <linux-pm+bounces-17508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730BF9C77E9
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 16:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380F9289773
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C85A158A31;
	Wed, 13 Nov 2024 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvedUzCt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADB13CA93;
	Wed, 13 Nov 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513330; cv=none; b=beUvuoFubZGtTIwdKnEn2zRFJjv5oH58RMG9kdEIr2P2oVbov2SbNnCq8LWbI5ChfB3EqbEEOK4sFJklS/WLO+GvWXsOteXD1ExG8OjDBZoxw6EZESil60O30VJSQxo5PTs2E+wlUi9SM9GGeMhPRvMrzhz9tTAel9RAtw0QDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513330; c=relaxed/simple;
	bh=NgoH+LrTAG89fScvk7ZEm4GCED4UiLCSJgp+OjHFJCE=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z12pr7bJb+zpAFIxEWoFi8V1C4PYB8qZt+MHMFUhDEzswPcIDkCNy1D0zE4T1kGx/zPYx5sfz7q4SuraHqC2jsgvRiUR75+p2nZkdUjPQOsX04pCMLvU4Jb17bViUyTF+qWfoahO8sF/wOLe2xvbdOi2mTdsuXHRUNi/SrBrnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvedUzCt; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53d9ff92b14so1135880e87.1;
        Wed, 13 Nov 2024 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731513327; x=1732118127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ssj8FultLibLw4mYJotkGqmjsM2TqGU2Jd6awXWPkCY=;
        b=PvedUzCtx8t6bmHn7+aT0yXo+11r6vcCHvFDzQZ50ipKa2aG3bStNAy8D6J1HjeX3x
         ZX03zJZhfYq6J/XT0esGlfakD3NNbwbfJGGbkjxFxu+nae/U5s+FiIUGLA8evXhehvl/
         25r8uFiCjikTbIkbRDiGMaCkp9Wcz0/BrpzaoKLJRbrgkPclhVcN1xg4z9rWH4NeJinZ
         rPpKygTtRyDJDDTE0t2KfKHCMfLCCn0TxQ/fjF3TSLKp32Xde8RFbrASAorBULqvIKYT
         AoFyXB+aKrlKr1cFIVLNe/LYDiKeFKfwTORkEEuVuK7rL/g64IsjWtUdxuGaccbfieQp
         zXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513327; x=1732118127;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssj8FultLibLw4mYJotkGqmjsM2TqGU2Jd6awXWPkCY=;
        b=sxSGNsp6j5DqKW8jfSQc/QpSbY24js2QmTqToio/sGdEMbNeKezS1js7lzuoVCvJl6
         9Y05JvfR24mLoyQTtnDJpqWiHURcDgwAvmyJzPRzyTQMfT6WuVEvnRMFN9cN7sk0VasP
         L+6LqUZO08/LGq1PMOdLQB/MQ6hVJZjzyqYDlLN8+mGZ2s365uH+kYLus6z1nM061JLc
         4dll2UJfmZwurl6dJ9JIXHIhEqvLagsTwcnFhVJ3ujZefPzpXTwhUrHY0qDxA3gZJ1Xp
         A+/C55KAVSICGkfHw5oxrb90M0DQNr4KPOSmiFgB2wiYebdyCupI8WKJ7cqxkncpmCvY
         JVog==
X-Forwarded-Encrypted: i=1; AJvYcCUUtDa4//DlWAo487P43bzLPJB7V3kKovaTo9CyGn5avn3Z1Ex4RdFQHxTZulGIvqckbAAFkbt1zfI=@vger.kernel.org, AJvYcCWWledWoBJZgcHE35XQTBsJXH6WU1mrCcCU5/uMfgKt2JbAXdolpuW8pvKswdPxjxOs6CGjaJv40DyqDTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQe/AH59FlK5WFbkYjeoEz8/QlUpgtSlZoXIuf+JlhICsnWz6x
	fdWuk4NLa1zwYPhE2ZiRkzV8lNKbDNLZGtDMD0wlAqO0cSOpLepttr5fXA==
X-Google-Smtp-Source: AGHT+IFAJCUb00pL0wJxdOI6F+JvN1qpKc7TIrQnC8l/tyw4JX2h1IkyZOaG0fObWYQGSsI0hh84qA==
X-Received: by 2002:a05:6512:1049:b0:53d:a28a:8e99 with SMTP id 2adb3069b0e04-53da28a8eafmr1065156e87.19.1731513327232;
        Wed, 13 Nov 2024 07:55:27 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d4788a31sm18551935e9.0.2024.11.13.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:55:26 -0800 (PST)
Message-ID: <6734cbee.7b0a0220.d8678.60ff@mx.google.com>
X-Google-Original-Message-ID: <ZzTL6YSNbge-IQ7Q@Ansuel-XPS.>
Date: Wed, 13 Nov 2024 16:55:21 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>, upstream@airoha.com
Subject: Re: [PATCH v2] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
References: <20241017190809.16942-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017190809.16942-1-ansuelsmth@gmail.com>

On Thu, Oct 17, 2024 at 09:07:49PM +0200, Christian Marangi wrote:
> Add simple Cpufreq driver for Airoha EN7581 SoC that control CPU
> frequency scaling with SMC APIs.
> 
> All CPU share the same frequency and can't be controlled independently.
> Current shared CPU frequency is returned by the related SMC command.
> 
> Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
> driver is needed with OPP v2 nodes declared in DTS.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Sorry to ask but any news with this?

-- 
	Ansuel

