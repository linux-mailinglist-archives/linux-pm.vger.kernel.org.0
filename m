Return-Path: <linux-pm+bounces-1014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4244380F5EA
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 20:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F9F1C20CE7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96C68003D;
	Tue, 12 Dec 2023 19:00:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60148F4;
	Tue, 12 Dec 2023 10:59:54 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-590b52645d3so80906eaf.0;
        Tue, 12 Dec 2023 10:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407593; x=1703012393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mzj61VxAkYjMa9ZFW6YfnczRS8Kp04ye+pxOmrS4Wck=;
        b=kymreGUkZMBKxcS9ZFJq3lxgDEcF5s6w6ItL7VR9l6EK0cSxz/tkcUSu/W3yC14LW0
         5PCqM6A8MiAyW3BD3WxZ/zjuDnNK4lD+ySwoEbgwvED2EPFGR7/r/KqAiDyFMtaWLyb2
         TV8NpsR1i5todjpoS748zpZST+f+pa87SInbOtzd39SxCqvv1l2uAgLepq30CTulCg6m
         nvkigTlhrcfe6aSEb0fvK8VlFKPvQmgpUwMou7dhJ3HJBkR9PcsjuW5oQWb+qBrCvkYb
         BjLhhf57k+eV55LeW6ySS2YieuVpLljbms+t/XzEgZwtpHxAmAMOa8mvVIpMLL1rgG7a
         r0CQ==
X-Gm-Message-State: AOJu0YzEhHR4orwp0VfkIO8oPRxS/3dQubL2cyzVEuDlnYOBH3oWnu7U
	j4tN1QCkl9ix7Jq1ywXI54RZH+/gawqx8WcdwighnkGSagE=
X-Google-Smtp-Source: AGHT+IGR21o+E/mrahk2CQTuo0IxxmmtbVfzTqcPdrNk0J10ZFZPNZnPCI4f2/pVhYHgJQBNjWMSJv3Xkft3hKgVb/Y=
X-Received: by 2002:a05:6820:2a18:b0:590:9027:7ab0 with SMTP id
 dr24-20020a0568202a1800b0059090277ab0mr10040026oob.0.1702407593440; Tue, 12
 Dec 2023 10:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5733564.DvuYhMxLoT@kreacher>
In-Reply-To: <5733564.DvuYhMxLoT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 19:59:42 +0100
Message-ID: <CAJZ5v0hU12yWQstAFuDkid0iWxdh7biPy33BA8XfhczFWCVX5Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal: Use for_each_trip() in some places
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 8:49=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> Hi,
>
> This series changes the code to use the for_each_trip() macro in a few
> places instead of open-coded loops over trip indices.

From the lack of comments I gather that the changes in this series are
fine with everyone, so I'm going to queue it up for 6.8.

Thanks!

