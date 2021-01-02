Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C966D2E8716
	for <lists+linux-pm@lfdr.de>; Sat,  2 Jan 2021 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbhABLai (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Jan 2021 06:30:38 -0500
Received: from msg-1.mailo.com ([213.182.54.11]:34514 "EHLO msg-1.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbhABLah (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 2 Jan 2021 06:30:37 -0500
X-Greylist: delayed 1297 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jan 2021 06:30:36 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1609585697; bh=dnO06Q1YUB2j63IjXJb8lVTTTn2kGvxLE2YGhM0ooUU=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:MIME-Version:Content-Transfer-Encoding;
        b=E2qVLbHUjAc6hC6sD68iM7MsADPbITCSJa8QdM8Fj81wHe/qvyR+YwktoHnrZ7b9b
         nZofTneJu9SoMx3x/9mWGy5Mg3J7r0DO9MRSao7H1OTS5A1+ysEzYab1RdWKhGFkRv
         mloamntuTCNEu/eccouxQLg+vZXywcFg9egcWCYc=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sat,  2 Jan 2021 12:08:17 +0100 (CET)
X-EA-Auth: xJKG8fU4u25lkcevkZOWNO9XTjJltI6jXZpd8ZQShBqjxnNONToa9RDmKkGc7SvnuNzw7RpOrpGageGwMwRON9XkDjBBgAaUEkI3Hwwf7SQ=
Message-ID: <d869ea94b3b1c73800a5c3b855cb6f280be6c185.camel@mailoo.org>
Subject: Re: [PATCH v2 5/5] interconnect: qcom: Add MSM8939 interconnect
 provider driver
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Jun Nie <jun.nie@linaro.org>, devicetree@vger.kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Cc:     shawn.guo@linaro.org
Date:   Sat, 02 Jan 2021 12:08:16 +0100
In-Reply-To: <20201204075345.5161-6-jun.nie@linaro.org>
References: <20201204075345.5161-1-jun.nie@linaro.org>
         <20201204075345.5161-6-jun.nie@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le vendredi 04 d=C3=A9cembre 2020 =C3=A0 15:53 +0800, Jun Nie a =C3=A9crit=
=C2=A0:
> Add driver for the Qualcomm interconnect buses found in MSM8939 based
> platforms. The topology consists of four NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
>=20
> Signed-off-by: Jun Nie <jun.nie@linaro.org>

Shouldn't some rpm ids be changed like they were for msm8916 in the followi=
ng patch ?
c497f9322af9 ("interconnect: qcom: msm8916: Remove rpm-ids from non-RPM nod=
es")
https://patchwork.kernel.org/project/linux-arm-msm/patch/20201112105140.100=
92-1-georgi.djakov@linaro.org/




