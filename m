Return-Path: <linux-pm+bounces-39968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95DCDFFB1
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 17:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73AAE301C3E2
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002A324B0C;
	Sat, 27 Dec 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDhJKqxm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9431A7E2
	for <linux-pm@vger.kernel.org>; Sat, 27 Dec 2025 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766854411; cv=none; b=Y/ExO0YqafYfqV4zYRMx2s5gi5LuCjl9fNXFLYLo7mQYjRD8SBaJjVCS8Z56GgMVkjC4kZZOVvOhpkWBcV+PuxFw7vJBxbfBsB552BMvjbCRbYP+PYUrkkpGv6w13scfiTikZbQpsU86vCV7G5adXouc8au/BJJv/U5gD3LYo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766854411; c=relaxed/simple;
	bh=gu4P8yCtGv38ojTrodppXUMSDmAq3ug24zzKR6LldJ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Y3ryQumhuqjxTJ5s8MwssrXejOj6i1JveMoKp2d4PTsxfPR7bnD5WnMhqj8XF3K6VZ/uAaVoSVj5DtSOsLNSl6rSqlhyXVa2bkOvICPzHUC0Lf5hAKfhGUj5tCyTQACDeYZmkiI9TBUQDxL5zvcR2tWC44A8NE+6dPgGwU9+wmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDhJKqxm; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640d4f2f13dso6915780d50.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Dec 2025 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766854409; x=1767459209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gu4P8yCtGv38ojTrodppXUMSDmAq3ug24zzKR6LldJ4=;
        b=QDhJKqxm7FEZ4RFnti2R6tTqK7hH71vHV/VblwD6XBiZr35ArhxkMjygs3OtTmFvtm
         GQ1AmgwfSWQWL+gElq7vwkuZxf7q15KuUdqRblWZHBa5u5182q8C7A4C2XA4t6uzpKVX
         +pNd4dtyEqS+H4yN0jP/nFje92W/Rymy9ExrCqlaR3XpzR80zooQy6x8VpCA23ZD4qYf
         s31Z59m4lqS140QE9rpScOvahBnTZ1C/ToyacjYxwYseGZDw31pF6UDbPh3V7QuYIDxN
         Qujj3bknKQuzHI2l7qf60TMVrYFbmcw4wq7t6uSL0Ohv3827R1oksyZgH0fG/ILY6khr
         UNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766854409; x=1767459209;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gu4P8yCtGv38ojTrodppXUMSDmAq3ug24zzKR6LldJ4=;
        b=IhIeGbrkh84MCQL9nU11uwYlRONOHE0n7w0IZHVQNTGMmdYe9GCJ1g540PNFBCieVY
         XrKK/xBW+WqAGdPnx7d+RxBSCiBbI5yqrEo9LXorqOeUrizNXHPPSHqe5/Hez8jCeqo8
         tQFn+CxIqlcAyeP9VnyFjP8Jit1MPuXoVjHs72j//3hTV5Mt2HNHDMPdk0zUiudx/818
         ahBRqhSbdgSZzLr0IAFvefvgLDKbrxRnm/2scpKlxTGaoFhz2kXQhDigDwnPnD9zq902
         2FwYz9mS+wjcwDkU+RCUglamoL4em4l+SvL8Q8HAkfAzz8+066NTkIDjDsPmGQ1jhk+F
         V+gw==
X-Forwarded-Encrypted: i=1; AJvYcCXRTRBlAXQO5Uyodll7UWHwG6YyYTof4cJwzIOwedSCLJ1cJKMvIB1/C2PHtGbuiuWnEGdCXZye0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7y4IQKBpf6rL/ejCyo1D7TwqvbXnEfgTO6vtyE5z9gYr20VjO
	D/Fz8Xfo6gc8d/WjWlOGUVBBjX5wr4CfguXhmQpNO0OJ4toLSO+dRR1n+YETFWtR4foZ112IVG+
	bZsHwURZ8IntJgooTZN0XGPnRADnYSfc=
X-Gm-Gg: AY/fxX7ABmaiY7l5iGNJ8UI9OOqz7RNMNsgnJlIipVYrUfp16I/9s2mWO+pV6EujzRb
	K4ASLUB5CPoRtBWNb/Ju01O//8pV5W0d1lR2/ckJ/uG1tvKcD1ttfNjWMwZbC/P82DFEh3ppndm
	eza7UhXxGzb9r2A4l+IZHsplla1f1KvpB2Y25WYrm60jlPyK3S95yVcbNeWr3jwkGswDOb6itz5
	mPvB3gOte6ZmtGeLIsfGPsxBuO8nTNUidspzjJTKfWOHTOZA/79sYMHjzQq+1qpuzM2
X-Google-Smtp-Source: AGHT+IF3Ar92THam/YBoDFLspVYsbTbaPEn4UDgIjGwlo+OzDwvfQfbc5kNYDFIO2HEklpYYD2voIBzsATqCIeii49c=
X-Received: by 2002:a05:690e:ec3:b0:644:5d3f:844b with SMTP id
 956f58d0204a3-6466a8a89d6mr15524495d50.54.1766854408938; Sat, 27 Dec 2025
 08:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Date: Sat, 27 Dec 2025 17:53:18 +0100
X-Gm-Features: AQt7F2qYKWCD4_nduV_EbKeCZVZL2BRsDeJglVK1M4bYvsM7D9xgKCVpKAP_4SI
Message-ID: <CAGsSOWWMO8+8vB2EM8s1=hyN1raO6TDpqGBTdrmNrZpfDfn5wQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: dts: switch to RPMPD_* indices
To: dmitry.baryshkov@oss.qualcomm.com
Cc: Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, konradybcio@kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi,

MSM8937 and MSM8917 MSS would need more power domains like MSM8939 and MSM8953.
I am planning to send modem related changes soon what are interfering
with this change.

https://github.com/barni2000/linux/commit/21151cb3d07124897e4d3dad51c833c4af27f6e0

Br,
Barnabas

