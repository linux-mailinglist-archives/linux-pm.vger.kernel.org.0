Return-Path: <linux-pm+bounces-18497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0825A9E27DD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 17:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF17428809B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406A1F8AD8;
	Tue,  3 Dec 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffqX/vSo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF3D2BD1D;
	Tue,  3 Dec 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244211; cv=none; b=tGsXly/BX4M+WlKwY1+cXBkgOhjcc/3wo/M4zazWkh7nDra3Xt30fTxRr8CKLYgByRslghpPkX03vou0k/TDYFef0bUokfO2tfMognQqz5eyprzrNV/vDk8XrFtNsei+DFEbNKeSayFRTbrdFd8jFUlia5ibRAhMipRJ95AEFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244211; c=relaxed/simple;
	bh=RiisfK4pAZ4XFYQ0qcJb6xGVWJO1a0mox2NLwW3Bcpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoUPwPfSzkmxtpN4pw9WbtLm3C6XLwgvgTMzICWOjh1g3xt4h2cxN3bIbyz8M0xkMTjpIWQJ6K1vC4SU7JR0++PUBZkWZkR7nmMmBFZCjXLCMScxmV4tIMLDW4S9avk4UYDiTlMQB/Esf1CZYyy4VzFZlh+m+pYELLW/HEHojAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffqX/vSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198E1C4CED6;
	Tue,  3 Dec 2024 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733244211;
	bh=RiisfK4pAZ4XFYQ0qcJb6xGVWJO1a0mox2NLwW3Bcpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ffqX/vSoDazV5SozWsi6fo0l4euoK876VodyD7CQZz4LeUKPOGv3cy1aeudRw8f6G
	 sj9jbpMtHMBLIq5NUZg7xnUh59j1y4gbD6OaRokUywKwSQVJLm5FoCGxivp6t6R3xW
	 WtqDB923r4lqYGW1G8JfOvH4uw78dJNHY+cD0wc8VZBss+9+4z+ZmmzBhl/mGlcpTI
	 LrXLzqDwu7CRRNWfoGuiaMHp2L1SYsbE7lFnLCpEUPu9HfrF8U8K1x+xvYVAo4VAgk
	 F3JwXnbk6ajt4h7uVCIhtJ/ZFvvG2COsx8XtWw/EhEnxqzxcWyvuBf4+VLNMICP8or
	 DR2VGizTJ/r8g==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71d554dedc6so2337807a34.1;
        Tue, 03 Dec 2024 08:43:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVupfoEEEJ8hO2ZWfGRjRzeFPxMY2TC78zhqIRwIQVGj4FcNoqbjjcT+nEeb2OPMLFD4WHQrCf5uSI=@vger.kernel.org, AJvYcCXF9tRKkaql9y4jkeWtUxKU+Bt+ymBt/QexH+zIxoBYqmzI22akh9U+1MawGbss8acfvatWcN75JV25+FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSah4hBNu/ftiRGSdwxiTz5URMwVB7O86WaXyqJos2eF09lEi
	O6QD6lmJpdYJTNR7YvfYHig4dofXRiUUS2ha+EWBwmk2kMl9Sa71k4bPKacdXtlo12FwR4JJGPg
	sVraFCfhO3wzD5xzvgSOAx1NdyNo=
X-Google-Smtp-Source: AGHT+IH+1vpnfR4q9huVZvnSA+pXTvZUQa2zDYDMZB7hiVjQq9YCN8D6HJsDMyGoxcMRp9ujryi95flemjlzLwsbKGA=
X-Received: by 2002:a05:6830:3689:b0:718:9c7c:2b33 with SMTP id
 46e09a7af769-71dad6c74dcmr4219944a34.23.1733244210501; Tue, 03 Dec 2024
 08:43:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203075119.584419-1-rui.zhang@intel.com> <20241203075119.584419-2-rui.zhang@intel.com>
In-Reply-To: <20241203075119.584419-2-rui.zhang@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 3 Dec 2024 11:43:19 -0500
X-Gmail-Original-Message-ID: <CAJvTdKneoA7xZs-PwNsLBWf54TH7yi7TW1hjdoe19DA9OuKpzQ@mail.gmail.com>
Message-ID: <CAJvTdKneoA7xZs-PwNsLBWf54TH7yi7TW1hjdoe19DA9OuKpzQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools/power turbostat: Exit on unsupported Intel models
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:51=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wrot=
e:

> +               "\tTo get latest turbostat support, please contact\n" ...

"\t Please refer to turbostat(8) to find the latest version of turbostat.\n=
"


I'll create a patch to turbostat.8 to with clear instructions.

thanks!
-Len

