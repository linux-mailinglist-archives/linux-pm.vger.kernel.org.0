Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2F29ADF9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 14:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502165AbgJ0Nwu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 09:52:50 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33459 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502073AbgJ0Nwu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 09:52:50 -0400
Received: by mail-ej1-f65.google.com with SMTP id c15so2379359ejs.0;
        Tue, 27 Oct 2020 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4TbXysDqnndpTRF/Rd6isqCmc40s+e6qp/SrBCZya6s=;
        b=lwyXkbi/gj/HS/sa5ZvZZHWv3isYpIbQNCIWPd3kHp+iv2FtJXwPzAWNcRkUkXvTR8
         44f1TqgS3Bs2rpkI/0wLJ2Hk71+L3Ar+JX0euHhazOZZfsbBQ0jh4qOrYqZ/IYKprYMR
         7okL77/0uwXZTkRMwLFRhEHaeE4cEimNfoZ9ZS7H4rHZ5JsJPCXkilBuRfW52+VM3PNz
         J1cjxhhE3KHS/kc2JF9LiI3m5pFs/I1nntfqvyb8FZOpg/Wn4MwGD/eevDCR7ofLKqo2
         FY65HzvyUMidkVgJ7hv67tNZM4C41gC/ZJABYJOtFp+NDZvtzNotneRZEPMNdKEaw6wc
         HRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4TbXysDqnndpTRF/Rd6isqCmc40s+e6qp/SrBCZya6s=;
        b=eusKnF3RfVzOdDZEdQy/47MbFChfMi16kwh+A/mZVcnRFQ/AZucH7vWwebN4eeXYce
         dzg1yUQ3nonBXRlw6g2vgLa0mBAXPAGWeV4mgRxS7WA74Q7XsF4pYbirJx+HmI5qNLZf
         WPC3cPrWzDzQEe4LbEbvSo7GrBRwF8cRqGx35GKAkbx9se/TGiASbTTDtd930yfKJ8DI
         +HnIpTLXwJfkO6KkpuihrC+cSuxQFyrUrknaR+zU1BrdrSZOUcE5c0pNJpSaI5rU3qWS
         lZEr+4gT+Jk8gztjJWy3SFaRiXwGZilI2UretY19MObxcfbXQZcuVW2PyzgfnxE3D9MP
         kV0A==
X-Gm-Message-State: AOAM530GiXgN4DKptb3RpB+vIiN5PoiwfeDFbh8blWpwacaMHEDOZ2iu
        PhQNK1JEBvjSE1HRAKcHTZI=
X-Google-Smtp-Source: ABdhPJw+wS4M5IdvdBE+C5XCShNKfDZ8hVzHzxdKtDgQPwv8S1CiMKIe82JbF1rjlL+EXlOuu+VahA==
X-Received: by 2002:a17:906:f8d2:: with SMTP id lh18mr2599173ejb.457.1603806767898;
        Tue, 27 Oct 2020 06:52:47 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id rs18sm1096635ejb.69.2020.10.27.06.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:52:46 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:52:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 32/52] memory: tegra20-emc: Continue probing if
 timings are missing in device-tree
Message-ID: <20201027135244.GM1822510@ulmo>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-33-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OQhbRXNHSL5w/5po"
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-33-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--OQhbRXNHSL5w/5po
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2020 at 01:17:15AM +0300, Dmitry Osipenko wrote:
> EMC driver will become mandatory after turning it into interconnect
> provider because interconnect users, like display controller driver, will
> fail to probe using newer device-trees that have interconnect properties.
> Thus make EMC driver to probe even if timings are missing in device-tree.

Does it really have to be mandatory? Sounds like that's going to make it
unnecessarily complicated to merge all of this. Is it complicated to
make interconnect support optional in consumer drivers?

Thierry

--OQhbRXNHSL5w/5po
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+YJiwACgkQ3SOs138+
s6H3wA/9G28Ray4Bi6twkE9N7+h/sNEt+7YPAHJDE7CAIf9/VJ6pbfqyZFWHTH++
/R5TsxsZlomEwSgf41l2E82KzNVLiJ0uRA2aKSS7J+S7navlOQHB2iHA4Mt2L+wm
z2l48XHXTeN8HT/RZoaPK+ud5dShtzJkyrQ7Iuije9XY2f7EaSogO1be3P6lQTpJ
L5tf04hyF0l9obliNMBD1kip6SHt/XLVo/Vdkl95GZz4Utu9XNGOBdkQ0jib8DGB
VTc/qWdeJUlxQBABfFXBGYXoS5x8xkOe0C1ftx+i1fiJpQ4z7QAaHKb6i/h5E4t3
D1iTraACToaw2f5Rcidkjandfmw2UxeNh1i3Q9eLDFwZhNTnBsXKez2oajbgDDHJ
3RQZXzm57261eInfCxv1NTLk1TwefZdC6fHMFya/1d71uxpxrKaZOiqI9R/2V35c
Qu3Bxgktem+U8dVHrsNZwfaXPIafdyPU+SCczsLFNaIerh4HVFan9Pf3ygTb5835
WMms77JprRuy8oDnApuK2Tx5tRBf1ETy7ATUxIs40dNTQuVj7VT5biBr97LwRyKM
4O1+PPLbS256d9z7komAWyF1q/gJUCdQRLtaD3HL6WQdFZmZZABv8S5tclu71lPn
o8htSjXOmi7ZPGn/ipBe0RMBK42ehXK0f2gysAj+YhzVWqva1JU=
=XJw5
-----END PGP SIGNATURE-----

--OQhbRXNHSL5w/5po--
