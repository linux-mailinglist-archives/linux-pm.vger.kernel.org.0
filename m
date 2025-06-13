Return-Path: <linux-pm+bounces-28692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954B7AD93E7
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 19:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91F41BC17B0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65611E1DF2;
	Fri, 13 Jun 2025 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8bxLJx3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8D2E11AF;
	Fri, 13 Jun 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836765; cv=none; b=W6v+CYRQ6XGTA00U3tXFji0T/xT2SC7MN/U9434Zz1R1KksdQeFtv9V2tvwIqW9Dgu0soumne79T7yWIryymNjHcil+Iu7YpOSDa89B0rZV996FfjYNj7YoukfIYZmyEgJyXk+LYW1X8aSZMiFXu1R2YDJDpY/7Hw0VL4kgMaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836765; c=relaxed/simple;
	bh=E1CAs9I3Bl6bAji658FN5T6DdKnek8IoObKmUgz9ZLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2OxuExCUkTfl+UezsePGPXJpH0YKACEUMexfumNTFO1ZKbX0lvdnkaswGicqU7XpOv/yurijcQEk4bkETkRnMwgBU9hl+RElL3wHdoAZ2HF5K1J4gI5kOUDako+kkyPC28SUjk56LwOq8lsyBLuPe41+vlGST7ATTEHvBGbExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8bxLJx3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a54700a463so1693869f8f.1;
        Fri, 13 Jun 2025 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749836762; x=1750441562; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7o6LgB7AIkkK7r/dWQxcX71VitA91tOarrZtPxNhdw=;
        b=E8bxLJx3lVlAPHUxIIVF5gP1pd78jHskmPaqlekNawsNvzgZLGV825l50bVyfg8dkM
         C4i73iKJx82K1dDAd1wlY6mgLF52rgbcFU4HFolBo5XOXt33SBR27g/93KXxEHvQrIqU
         QtPZA6VELPl9WI38gGtTutyNtVsu7tWOg3d3uV6GSax+m9riWiPQGSk1R+LbzPpL+TH9
         LJju2+7rwfPBAcmsZu3iidABqv8TbgoUBpp1FeitC+H3quKiJf0Tkfp/vljEkmInuGX1
         ByA8vRJSN0dGXxKkqnYzS7LxIRlLLDAFzyC73AwWWts1eQAkcq9SWA1ngngjOY6DEW34
         g1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749836762; x=1750441562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7o6LgB7AIkkK7r/dWQxcX71VitA91tOarrZtPxNhdw=;
        b=hg33NFb7lLQmXJv9CrTi/ojxZBb34wVZ3C+pF0joV/K6KRmiB7m/HPB/qLqaXYYmZJ
         VZO5IPNqIMqNM/7NEIiVV02B1rBET1ha2cCfLmMlI/ORU1NKb40a3WAHfeq2ky8HTcwD
         1JlSVgtA/rlHjXejQ+H6QknZpUIyTD4jvvodL2A/Cnm7d1qBd5j+8XJ/5Ke+4JX7SSG+
         v/M3C7Z7eAirTabuFH6Sqfw6JPic6l+qWWyCTdoAdmcQTwQ+OwZAGPd1X+vnDFxS/OWF
         Qjgy0SiRQuli4pr6ZEZsuBVUHX8cCdPPQ8E/TIH7+1HLcil9HimYijEqM5cWySujU4cR
         kiPg==
X-Forwarded-Encrypted: i=1; AJvYcCW+GjB6GLN7v8ayMHMfeLjkL2uaDbW8XJZBLI6orKTica7F6f7gDH1nPVOjz5fIB2sYQ4gJMVFpMBBScoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzISHakAaYLA1pHeba70eGO/rrBtJ+t3wicN3D587mzavfsWK
	RAHMKo4/nzhQVhbnOiphIvUiuW8VA8kVm4yNZw2p0KawusyBnpRKsn7U
X-Gm-Gg: ASbGncvJmZnDhQBdmeIjs8uuhoZ/7TN9GMahxBNGPuhmfcKlnnkrDoWnfC/wLPJ9xZ4
	wPePAVDRoZq6/QP6Wiu40zjvspWA0CZFFb9W9yIGqozGB5lbiRgZnK6h0pAGrbxMbnyWRbmEbsL
	p9NQNFCVM0H602jjrmONlyqnzmMcRpu5NTFJqHJNALwkxTyus4qdVarc/M3JLuMg8PzCGt6dtCn
	avCp6bUo0gJCxn70QW9oZoXLYO3B08DpkH8ZJWtF/84Z6J4NaPkhPALjsDiX2TEMpGp4x7VQ31x
	yeDezguvDWTNWEBqIhhC131oX4GCml569MESngH31Ufmq3lweMyDxTr6anusHHmhAojS/jti2c7
	0og==
X-Google-Smtp-Source: AGHT+IE1GHPidTcikKR9hQdtjMOMkWc4BcYjavA7DREfS2b2HpPP4JObZbGROJKY8gwS0khF3F+fJQ==
X-Received: by 2002:a05:6000:4025:b0:3a3:598f:5a97 with SMTP id ffacd0b85a97d-3a56d7cd473mr1858505f8f.9.1749836762305;
        Fri, 13 Jun 2025 10:46:02 -0700 (PDT)
Received: from [10.245.245.66] ([192.198.151.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224cb2sm61493715e9.5.2025.06.13.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:46:01 -0700 (PDT)
Message-ID: <17f85f0bfa5446b86188616349b17d02fe207c22.camel@gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Fix build with musl
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
 rui.zhang@intel.com
Date: Fri, 13 Jun 2025 20:45:58 +0300
In-Reply-To: <7edd4c688111a697cfe913c73d074738b3d1dffb.1749833196.git.calvin@wbinvd.org>
References: 
	<7edd4c688111a697cfe913c73d074738b3d1dffb.1749833196.git.calvin@wbinvd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 09:54 -0700, Calvin Owens wrote:
>     turbostat.c: In function 'parse_int_file':
>     turbostat.c:5567:19: error: 'PATH_MAX' undeclared (first use in this =
function)
>      5567 |         char path[PATH_MAX];
>           |                   ^~~~~~~~
>=20
>     turbostat.c: In function 'probe_graphics':
>     turbostat.c:6787:19: error: 'PATH_MAX' undeclared (first use in this =
function)
>      6787 |         char path[PATH_MAX];
>           |                   ^~~~~~~~
>=20
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

