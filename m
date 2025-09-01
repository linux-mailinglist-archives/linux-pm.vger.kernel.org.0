Return-Path: <linux-pm+bounces-33520-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A2FB3D91C
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 07:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC183A18E9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 05:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF4239E63;
	Mon,  1 Sep 2025 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbZSZPt4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B741C84A2
	for <linux-pm@vger.kernel.org>; Mon,  1 Sep 2025 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706140; cv=none; b=pea4Kn4/UHqYBUseCeZN5i3HLlAeTk2wH0MQ3BMJyCa0IvQ95+Hm/C6hHORfU0qpUi8gNqJYYO98F7dFbNqFxvUmMAwFP9+9jYrtdzraUGyfHUh7iTYi824swibSZeFSUcKfH53Y9BlRFZLnYoxMs1E3GgXwjYrh4biVfgSM/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706140; c=relaxed/simple;
	bh=ysPSxLTOSZHYwF4LRPDLjQvZ8XJCJtmRSnHEND7/bik=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=peeEP+ED01u8nCoYvh14VNTe7L2wmXMZmtcB+uVJ8FtYlPd+U4kK49pb61a1U/qDqBeXpkvm+PHt//WzFUrXfBAtUe6CeXpAa8KJCXELL7Z6F4c2U5Ug1p/xUdP1jzMJDc8LAVWhznFTpu3INRgEiKKYf6qEMa+hnIqtXizheBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbZSZPt4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7f6f367a1f0so483911885a.3
        for <linux-pm@vger.kernel.org>; Sun, 31 Aug 2025 22:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756706137; x=1757310937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ysPSxLTOSZHYwF4LRPDLjQvZ8XJCJtmRSnHEND7/bik=;
        b=mbZSZPt4jMRvKIv9s8K4VFvpu8Re50Y+Mb6NFnLVHhmGUbeDQ8INJWVCDai2E9couF
         AIAmrEuyuitGNWfH+HZE7z5iRUdLtJ2vYb3fM27B7Z0y39mGmSZAVpEdEcspSxJZgbyI
         dGFIN33Xyvlk6PnqfxxI9d5ywzNXSvXUnXbMMG+TF62tXek99isTBK8S18ws8WH4XK/y
         Q8AvsT0FXZAfO5uk3ZHDb333L9QvHNmb5h8MAHBgkbwH1a0SopK7BTJvKh6mgtpIcf9g
         oW6Eo0jzZ9RvdXY/gwvlOJqrtngR/GrC2s/ryoyd9Fg+smJddeLmECQNyp/9PXmfBaTp
         R9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756706137; x=1757310937;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysPSxLTOSZHYwF4LRPDLjQvZ8XJCJtmRSnHEND7/bik=;
        b=aDrvoGUKDLnUn2Tbl4AUUpLgOX9CzJbEV9NvYznygP85iyyEBzXn2+L6VD6ls+lTyv
         sbqZiL3cjvvv98bCc/ojd6Rr6ha1RKDiASTG25d/PCb26hZqcrtJYx6IekLPtfmDhS5h
         wmF39a63EXlI4spnNJqkQ95cC7kRN/fNlBHp7GwHtiQdRwV2yWmfK6nskTtXIzbtbZ7p
         pkJlvZwtCS4MHtAl9SQyuiMZbqFsqZiWgm8WTdxjfFQxqlM20+CIqfjdkuJO8amEC4rt
         IGUeKskirRzW4fFCqJDu+TFZQmTi7Io8U2q62T1ViUeK5Ut7w73ReMLdlchrKuWjjtlZ
         /3Tg==
X-Gm-Message-State: AOJu0Yy5j4kgJ4byvgmfvldekpv6yZfUoMtsvgZizUU4TwhsBX+MyvnG
	dMzbvFQVbQzzLVmQ4tw5R+3+agJoUKBpFvWSJa4rJMsPWo/uquMhj1081BIYpJS5+jMe7kfttGg
	WnIxkjB5NebfmxgJiS6DW/Eh40JO0RRZUXv4=
X-Gm-Gg: ASbGncvjX7R/vK0VGcZ8dpAP5RHc9ZY1SyRq/D+FVvFlhuKstXyeLPm89FVt+FJmvED
	FRHb6atNRtFh6H3OlTfX957MSt+vtXfDNsWQyCXgiKWd1//lt5eWjqlkOtfwB19LPH/sIArmUE0
	ZN7h0YiueYJ5V1wv15vs6s2CjJ1vor+pQ/NTPrBzHBruL+fJ/V2TYBtoUcpzzGdf+Wnv28uSLPB
	GXQVRxER6fM9NuCDlSFz9XkpzEUWk/fKowkmURw2Mun7e5uE8O2v8tL1w==
X-Google-Smtp-Source: AGHT+IHBCAtPam9Ayzw4i/MyV7PGWN04QoGamPeWkrNeWHb0OA+/5R/3LFsiVC3TnOVwZTaWgX4M2axdtUKsdGPXwiU=
X-Received: by 2002:a05:620a:4610:b0:7e6:9680:51c9 with SMTP id
 af79cd13be357-7ff2878ffb6mr824245885a.35.1756706137497; Sun, 31 Aug 2025
 22:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: goldens <goldenspinach.rhbugzilla@gmail.com>
Date: Mon, 1 Sep 2025 15:55:26 +1000
X-Gm-Features: Ac12FXwTUIfHIwHIE58sxWcqDbtev7Dc-4pX7k4ywlwEaE9pQ86oc5HCKfj-7Lw
Message-ID: <CAM-0e4e7hOkgk=HcCNYNh7DwAhGmcoh=y=JGC3y++Ak6erd7Rw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix a regression leading to EPP 0
 after resume
To: linux-pm@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"

Confirmed that the patch works and fixes the regression.

I recommend pushing this patch to the next stable kernel update.

Related bug report: https://bugzilla.redhat.com/show_bug.cgi?id=2391221

