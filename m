Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA41C8D2F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfJBPon (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 11:44:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35267 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJBPon (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 11:44:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so7517046wmi.0;
        Wed, 02 Oct 2019 08:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rw5jKC8OGucVDozLco5ojghsOIfhGWFzK0qNPccS9GY=;
        b=P/H7Efh8WiJSl4k+6Brc2+i+qvOh7a47TuNsaSdasYczsGjHLATrbEoEUqn53OY73n
         siMmT4m+4q0dOs8MZC+h5UDzdIKjh9tKMvypa59NAn2YzCy2y8HXv8TMzxLNGQVQfARV
         k4QJkVgIx+3Jy1eX6Qeeq63n+7OTQkWkpDPc9VusQ1eL3w2CnrE1HTcOwN1IJklsTRkg
         DwBSMKu8wf/7kQzbluGyIuIj8yP67FA7VEjTZUOyzoL2T4JHN5dAW52Hq50lrLcLDFdN
         tZWT79nAYi2AcRrlGsLiJwsXG0JC077GCM0l4iKRy+/PcQAE0csP26QLTMSMIpXg7DQ0
         LiYw==
X-Gm-Message-State: APjAAAVtE4UnqwEB9yS2U6Q1cj8SfdmBnZvQIqS9S7C7IbUVwcwEdE8v
        5g6wqJjVEfhXKcgpdZaW+QI=
X-Google-Smtp-Source: APXvYqzsAkCLBGBVJzQidK1zPKRxtayFetKKeIH1OJPHVj1SYsdQOee6/yZsaG/xLJ18XWMsurQGTg==
X-Received: by 2002:a7b:c398:: with SMTP id s24mr3558491wmj.78.1570031081030;
        Wed, 02 Oct 2019 08:44:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id c10sm31462810wrf.58.2019.10.02.08.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 08:44:40 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:44:37 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     vireshk@kernel.org, robh+dt@kernel.org, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v4 5/6] ARM: dts: Add "syscon" compatible string to
 chipid node
Message-ID: <20191002154437.GB3469@kozik-lap>
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
 <CGME20190910123644eucas1p234a55b19e68046900539195f55ea60dd@eucas1p2.samsung.com>
 <20190910123618.27985-6-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190910123618.27985-6-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 10, 2019 at 02:36:17PM +0200, Sylwester Nawrocki wrote:
> The CHIP ID block in addition to exact chip revision information
> contains data and control registers for ASV (Adaptive Supply Voltage)
> and ABB (Adaptive Body Bias). Add "syscon" compatible so the CHIPID
> block can be shared by respective drivers.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - none
> 
> Changes since v1 (RFC):
>  - new patch
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 4 ++--

Please do not forget about exynos prefix in subject.

Thanks, applied.

Best regards,
Krzysztof

