Return-Path: <linux-pm+bounces-25488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B86A8A560
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 19:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC2C4432BB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 17:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F055721CA12;
	Tue, 15 Apr 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0+lWqCT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89B187FFA
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738038; cv=none; b=gnD9wKnGIKjnQjCC3elEdBxuhLP6pRStA34Coy0q16TeWEIggzIOpxmQxMI2OBmBJti502XdA+s1K4vla2BC/MRmfDJPr7EENxrjYXnmV9x93h1hSRqvm6kAqSlzOXeGl1rEWDXXYSQFk/Z5n7jAECWG+waZ4ULN/s6/ujnUlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738038; c=relaxed/simple;
	bh=TAXVbUDrPrJElYvVs9q0e0tBApVX5STLPTgNmRVYkJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JL4nnvOvamOvbyjLvEt9U2lWRM3PfIddMZ0XEEi4pT+Sx5GaEwfswy0EohHB9VcGHPKvR6XQ7rx8xt2DxC3AQTnwEyQpqFBJabmWFhHuh/Oq0eeDXdjz8niUvfRGJTHteDD0Qyrtpiky2sI873F3NG0svSF1ol+yjpT7a/MpKLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0+lWqCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4412FC4CEE9
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744738035;
	bh=TAXVbUDrPrJElYvVs9q0e0tBApVX5STLPTgNmRVYkJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y0+lWqCTDoq7N5S1b1TJ+xfYo/ehXhak3lR0FaC6ZnC3fyM/M/3TwIKH7Ad3Vc+Tq
	 VVYktHFX8VFpMpKrSfnW64OSaF9/FUOHa4zyNjGSQDWDdFGgP+WkdDsE9WdYKcMxNq
	 qFce8mOxz3299sNqBEEoYhQ+cq47ImlF4p9UdfY+0Z5B93zhLUbUaU0FVlb61t5q7F
	 yQX/IOjSBAW8/tLUu77faAHeB7sC70PD43xYS+DsnC9r6vKjVPRXuUagJ1Begy8Kxi
	 IZxYp2lFqPQx6siWcuYDzfBCaN9R0GFQx/LcG1PTdL6QeFDKNj4j/S3Bmus+mX0Wff
	 U3SO82lcSABvw==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72b0626c785so4547507a34.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 10:27:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YyHZ9BmTAnsJEB5jg+OxFwmbdZvbv+73hq0GAG6rUmhVUzxyqJX
	QtJEmv6PhK2eR5QMqb6dWmgIF3f2U1eHh1VUQQXjs9doxphLwusdXVbQQ2Q968mfebuiaRvcsXT
	cVuCf2HZLwbzOkaKF1WftJt/T7eg=
X-Google-Smtp-Source: AGHT+IFlKmnwv+RrqfpJSH/9jxeux2uMoOWJlFNQAxlGBGO6kFVykrsYOUBL+GbIJl3HrwTREU26g/kOu4PsfcKdRLE=
X-Received: by 2002:a05:6830:6b0c:b0:72c:10db:f210 with SMTP id
 46e09a7af769-72ec1b20df0mr120632a34.13.1744738034653; Tue, 15 Apr 2025
 10:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-2-sakari.ailus@linux.intel.com> <20250410201342.GA29836@pendragon.ideasonboard.com>
In-Reply-To: <20250410201342.GA29836@pendragon.ideasonboard.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 19:27:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0icciJsO3Jxj9xztPVeG7hqJ1Rk7Agxn82168JFzptjsw@mail.gmail.com>
X-Gm-Features: ATxdqUHpPf1sT2SDSGejK5AvMSWdvKpBghqu5V-Kf8EYbETvuwOQxskqKRNM2OU
Message-ID: <CAJZ5v0icciJsO3Jxj9xztPVeG7hqJ1Rk7Agxn82168JFzptjsw@mail.gmail.com>
Subject: Re: [PATCH 1/7] Documentation: pm: runtime: Fix a reference to pm_runtime_autosuspend()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:14=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Sakari,
>
> Thank you for the patch.
>
> On Thu, Apr 10, 2025 at 06:31:00PM +0300, Sakari Ailus wrote:
> > pm_runtime_autosuspend() got accidentally renamed as
> > __pm_runtime_autosuspend() whereas the intention in the patch was to
> > rename pm_runtime_put_autosuspend() only. Fix it.
> >
> > Fixes: b7d46644e554 ("PM: runtime: Add pm_runtime_put_autosuspend() rep=
lacement")
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Applied as 6.15-rc material, thanks!

