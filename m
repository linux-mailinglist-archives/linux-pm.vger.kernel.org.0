Return-Path: <linux-pm+bounces-18919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36009EB356
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 15:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E28281C2F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2A01A9B23;
	Tue, 10 Dec 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3PCMEa/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32019D082;
	Tue, 10 Dec 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841060; cv=none; b=MByJJU7JzGnK1/wWpdtzvaGgIlp+oyiB6Ku1uHoZDclJeelBd35asg36A+/nn+axQdIfkCpPSWSMaLQ3XpWSXHMz6TaXotVz5xFPwRs40uyzjQqTuk7KBWVEycB72o6p2AARYv1JMOZmnvKSbiHgHQcE5rxFewxmFh8CtdkEhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841060; c=relaxed/simple;
	bh=6PWfkKXT/AMHAqxX7cfEJo3L2lk7EqER7ygybDmzlBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFAGqfS+DRKhFCDKVXWW9rWCqfB3vynCPQt4QPqCnR6UJFUzk2rt5tct+IHw8s1lcQYLi0kjY+igQmNX57osoGmN1JbctVTf7ecodY6nziquBQQOiHxF4cJBD5GeK0psqDInQI1Q+GxGxJzu0FJon6zjE71VV20eGuB6OmvborA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3PCMEa/; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-84386a6669bso292631639f.3;
        Tue, 10 Dec 2024 06:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733841058; x=1734445858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2N7XAtorM72yACmDgop2No+2dzqpehTFwae9k1iios=;
        b=L3PCMEa/gyJx4h65LyeEKPw2U96YiAVTlhNsrQBSBBmUYh2KOvslo4Gn3WUmrsAwwQ
         734XS+Z6eL7EYvkMKgTo277gytrlrWS1ib7yAQpwvhF9gEvqZkWCcAonjLF4SlRS1ZzG
         mvS1J5FtFqMyQ0cyH9ysUfo5VTdWJhABq6nVGz24kdvF7zRaTjiOIndTR77OkE6K8pDT
         jsrGTDR7ds1QUBstZuhEZN1wu4hE8/cOFG9Hr6XeHDpG6W21e68QX+G8ic/QzXntpGV9
         1LmbhLMRrUzFcoSMMUQRzAJU+7JlpDRM2ssDAK2q+bigVbU5eaWRHxAQwI4oC1Pk1FNv
         SNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841058; x=1734445858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2N7XAtorM72yACmDgop2No+2dzqpehTFwae9k1iios=;
        b=R8pribiYX5DYOf/oxds/NTmnWHYRoqnwQDkec+DY3gOfA0sG85X7vQdGAxpbmME5rC
         grIxMcJHFfioX0e37Vry1p5qjsNYHGSIspDbi9BljlSzR+2VgeYR2IDjEi+P/vGrV3Zy
         j10BCb9mXRlNAflSGj6uhW3aL5CTATi2mMVsNm1d+xAui7Q8ktF7pTFfO0BmVYZ1NZZW
         aZ8IcedwT4kCJwL83QWM0DZJBNd3V5SrZLKrWFu1VFbN9QuSmGJo7cF7lf/5iJmvAeJd
         kDdcysdW5YLDTP9b114R8WlO+nAX8UiyQd6U+H+vLqCfeQETnpJO2mNRbP+hlmdOqz8I
         +T7g==
X-Forwarded-Encrypted: i=1; AJvYcCWRDWtikDKMu45sLwt9TmW+j/Ot1YCeARuPVWWxTZ/bfaI0hsirpT6SREeQtjkaCYZ+JoQrKTzjcG8=@vger.kernel.org, AJvYcCWqT3i+bEemucQ8ahSvYWRwDay4MMLv92CZg39EEc8s78ZzxK2dWPhkea+TYCdJs7VPfH/rzuZ4kkcj7n2R@vger.kernel.org, AJvYcCXudHXPAC1zCeIlfbG/HKbjFui3pYRM12w6a5fnEZMpad6vOYZ25bgN7pJC+TvmHZAl8yBw8zSsJIYj6xge@vger.kernel.org
X-Gm-Message-State: AOJu0Yywdv570w5ztDqY06JCbFo5fCZOfNU/gPVVJlXSWIBrJxKKnMMf
	WP+k84IO9lrHjV3lkiEMutAfKJmBascbDW8wxzVRKmMUzevPssbO5IK+KZ7eEMtk5DIOdFEjFXf
	QN56eJgn5Ugt2VvQhKnV3P4CFTHk=
X-Gm-Gg: ASbGncuHy7ghI2UlzYq1LgUv1nG+a8kYTn81WfhrORcPj98x5RkQ6MVX7xSl5bOzabo
	NKvpKp4awNIyMJKXJf533tPeL8brCYUXtInk=
X-Google-Smtp-Source: AGHT+IGZsjUHNHgZScctt9GhUUISo0b3ncG99pwHqmoX8StIWNsTQgzRKfAm5Fp0Di2hDokmvL3agPwZ+93jj5g8oTU=
X-Received: by 2002:a05:6e02:1ca7:b0:3a7:6e34:9219 with SMTP id
 e9e14a558f8ab-3a811db26admr175649315ab.14.1733841056498; Tue, 10 Dec 2024
 06:30:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213146.238941-1-robdclark@gmail.com> <20241210111450.GA14735@willie-the-truck>
In-Reply-To: <20241210111450.GA14735@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 10 Dec 2024 06:30:44 -0800
Message-ID: <CAF6AEGs72rxvguSYbALWPL2FrO5coyijQXY4HEQdwvr8Fj4XKQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>, 
	Mostafa Saleh <smostafa@google.com>, Rob Clark <robdclark@chromium.org>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joao Martins <joao.m.martins@oracle.com>, Joerg Roedel <jroedel@suse.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sean Paul <sean@poorly.run>, Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 3:14=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Rob,
>
> On Mon, Oct 28, 2024 at 02:31:36PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This series extends io-pgtable-arm with a method to retrieve the page
> > table entries traversed in the process of address translation, and then
> > beefs up drm/msm gpu devcore dump to include this (and additional info)
> > in the devcore dump.
> >
> > This is a respin of https://patchwork.freedesktop.org/series/94968/
> > (minus a patch that was already merged)
> >
> > v2:  Fix an armv7/32b build error in the last patch
> > v3:  Incorperate Will Deacon's suggestion to make the interface
> >      callback based.
> > v4:  Actually wire up the callback
> > v5:  Drop the callback approach
> > v6:  Make walk-data struct pgtable specific and rename
> >      io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> > v7:  Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty(=
)
> > v8:  Pass pte pointer to callback so it can modify the actual pte
> > v9:  Fix selftests_running case
> > v10: Call visit cb for all nodes traversed, leave the decision about
> >      whether to care about non-leaf nodes to the callback
>
> Do you plan to respin this? I see Mostafa left a proposal on patch 3.

Yeah, his suggestion looked reasonable.  I'll try to get back to this
patchset today.

BR,
-R

