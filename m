Return-Path: <linux-pm+bounces-13971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5D97423C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 20:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3F21F26347
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C931A2574;
	Tue, 10 Sep 2024 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX9h3ZWX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39617A584;
	Tue, 10 Sep 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993109; cv=none; b=NNpfQyAXzzNI289fwe+ZXwx5L49Xn6rmhujknheutwdVetYXlfHDi/VgSNcanm65q5lTt6ALyeN91oIroZiUlboZCWP9zH3EXK8B5FiEXBdfgwOt+NSUsR6xqJQYIhh+M2BWdsj5j1BsNA8NsKhzIVIKo0FMbN6ctjW/97r6DTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993109; c=relaxed/simple;
	bh=8jOEfUlJ4aQjfMnJdvt7RW2nHNfRBXwN8ur21u9sbOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHuUlWXdiEOfMECS18pg1m4ScYaSiNVHYL0VjaDwXxYqvOqeo0EGt1H5TIqaCa0fkUB99bxxXVwuRZcsvhbdkAwtfeaqxB6OlJdVsRPQJqyYfgtjeRD6+Lud2xDlxDXi1dhnFtbM9aLOW2mwep04Qf5Bqwte4fZevA4hhj6CyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX9h3ZWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A38C4CEC3;
	Tue, 10 Sep 2024 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725993108;
	bh=8jOEfUlJ4aQjfMnJdvt7RW2nHNfRBXwN8ur21u9sbOg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JX9h3ZWXbQk0NVEMGdXLm7rJWVMChTDFPlxTLLbtDBB1kfNkjpQLEjQAXTR5hT0TP
	 W30/zeiPtz3uF2FZSYQ6J1qnywMT79y7KuRa49qf2aFLzK49oc84q0NTnAL/mBJUTR
	 KX0QiwCb7n8YAc0rIMQI2ejXfN/wfO4liNLTU+HU3VrLSVJnySsgnUQ0z4ibSgPIlU
	 j0QEVZzwQDbUjg7iM8rj7U4RY25/P3fH4kKJcEDIYTDHua0KasjYLY5W7pkqVv1U6t
	 +w/yiIbrSlZtsWgtanoq18K4VdgHVa5v/8sBsjOCpQW3SnVgnO1fnVGvYI2FooOAB5
	 QERU2CGu0Ad2g==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-27806115eafso2804571fac.3;
        Tue, 10 Sep 2024 11:31:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoXUanMvmatu2kCjDBpMVd1QllpguFKVt/YfUK2aqeZKi7ZCjMVF/5njP2sWPFlOgxWPG/RP4qQpIN5os=@vger.kernel.org, AJvYcCWA5ZQcZ+CG23VMm38ctTAnKCVUOv+sTjRONkfoApPkpmeVmwN+fNAxcytYlA6w30MFItW1O4jSWI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHb6i67LByzzU1QA4nA/e5FUvO1NxdjAJ1WUyiOrdxhpKyNMAA
	/T+LoHrclSTos9IIAP1k2RxWbS/1czOvyiprN7o3NaVEBggH+bPpWwZbjSsttkFualG2sYJqXZi
	65oJMeBVRcjFdmYOclbFrJ9erf4Q=
X-Google-Smtp-Source: AGHT+IGmgny2WjXpHHyCVsW3XtG4mP4x1QCTVUPkoBevKEdNYL0DMKGkq49oCDboYf29X7DIXd/lM/ik+fGZ0JfUgiM=
X-Received: by 2002:a05:6871:10c:b0:277:f2a6:8f94 with SMTP id
 586e51a60fabf-27b9dd806b7mr8359908fac.33.1725993107805; Tue, 10 Sep 2024
 11:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cf87dd5e-8406-418d-bd5a-1c2d3300e41f@linuxfoundation.org>
In-Reply-To: <cf87dd5e-8406-418d-bd5a-1c2d3300e41f@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Sep 2024 20:31:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ijfiHK8YpYCOMMRiKG6C=v=HfOCHyfME61OsYqrdv88Q@mail.gmail.com>
Message-ID: <CAJZ5v0ijfiHK8YpYCOMMRiKG6C=v=HfOCHyfME61OsYqrdv88Q@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower second update for Linux 6.12-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Renninger <trenn@suse.de>, Thomas Renninger <trenn@suse.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Tue, Sep 10, 2024 at 7:44=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower second update for Linux 6.12-rc1.
>
> This cpupower second update for Linux 6.12-rc1 consists of a fix
> and a new feature.
>
> -- adds missing powercap_set_enabled() stub function
> -- adds SWIG bindings files for libcpupower
>
> SWIG is a tool packaged in Fedora and other distros that can generate
> bindings from C and C++ code for several languages including Python,
> Perl, and Go.
>
> These bindings allows users to easily write scripts that use and extend
> libcpupower's functionality. Currently, only Python is provided in the
> makefile, but additional languages may be added if there is demand.
>
> Note that while SWIG itself is GPL v3+ licensed; the resulting output,
> the bindings code, is permissively licensed + the license of the .o
> files. Please see the following for more details.
>
> - https://swig.org/legal.html.
> - https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 76fb981ad6774b82f06703c896b492c8659b54=
3b:
>
>    tools/cpupower: display residency value in idle-info (2024-08-09 10:32=
:33 -0600)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.12-rc1-2
>
> for you to fetch changes up to 80e67f1802d0fc21543216557a68320c71d7dbe1:
>
>    pm:cpupower: Add error warning when SWIG is not installed (2024-09-06 =
10:58:35 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.12-rc1-2
>
> This cpupower second update for Linux 6.12-rc1 consists of a fix
> and a new feature.
>
> -- adds missing powercap_set_enabled() stub function
> -- adds SWIG bindings files for libcpupower
>
> SWIG is a tool packaged in Fedora and other distros that can generate
> bindings from C and C++ code for several languages including Python,
> Perl, and Go.
>
> These bindings allows users to easily write scripts that use and extend
> libcpupower's functionality. Currently, only Python is provided in the
> makefile, but additional languages may be added if there is demand.
>
> Note that while SWIG itself is GPL v3+ licensed; the resulting output,
> the bindings code, is permissively licensed + the license of the .o
> files. Please see the following for more details.
>
> - https://swig.org/legal.html.
> - https://lore.kernel.org/linux-pm/Zqv9BOjxLAgyNP5B@hatbackup
>
> ----------------------------------------------------------------
> John B. Wyatt IV (5):
>        pm:cpupower: Add missing powercap_set_enabled() stub function
>        pm:cpupower: Add SWIG bindings files for libcpupower
>        pm:cpupower: Include test_raw_pylibcpupower.py
>        MAINTAINERS: Add Maintainers for SWIG Python bindings
>        pm:cpupower: Add error warning when SWIG is not installed
>
>   MAINTAINERS                                        |   3 +
>   tools/power/cpupower/bindings/python/.gitignore    |   8 +
>   tools/power/cpupower/bindings/python/Makefile      |  33 +++
>   tools/power/cpupower/bindings/python/README        |  59 +++++
>   .../cpupower/bindings/python/raw_pylibcpupower.i   | 247 ++++++++++++++=
+++++++
>   .../bindings/python/test_raw_pylibcpupower.py      |  42 ++++
>   tools/power/cpupower/lib/powercap.c                |   8 +
>   7 files changed, 400 insertions(+)
>   create mode 100644 tools/power/cpupower/bindings/python/.gitignore
>   create mode 100644 tools/power/cpupower/bindings/python/Makefile
>   create mode 100644 tools/power/cpupower/bindings/python/README
>   create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupow=
er.i
>   create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibc=
pupower.py
> ----------------------------------------------------------------

Pulled and added to the linux-next branch in linux-pm.git, thanks!

