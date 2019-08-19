Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3A94C2D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfHSR6X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 13:58:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39205 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfHSR6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 13:58:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so1642502pgi.6
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2019 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=HoVmSkEe13oQswbHPUJHfU6oOJm3g2HoCRDfFS6v2nE=;
        b=WRSqAnMYQuRmKa8OeeXjBJh7hCRuFuvWgw3KW8lNHU+42UKEiLm3GJsfYWFUWUKytk
         YajmqMxJ6pqgduqWCTAMQtoStuBtKaMGVWmRpWGO6r7aZAk5ohA6+8OzL1TmME5HbInZ
         Jne+raVcvh/vvA+rp+fFzaTSjISdN3IqM9Dsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=HoVmSkEe13oQswbHPUJHfU6oOJm3g2HoCRDfFS6v2nE=;
        b=bQNA6qMDVSDrcBvXXoFKdgWjuokPvQ3k4oAgClA5LmJ0phmqTLb8m0SbJfNEpmQEYc
         9fKQvripjdC54e8PILBjyD9IF3w47zEXmUNEpN5ckrEiYLOIzKht0CO4tOSGfYWJOmEI
         pSOCS8yWMQk53xSgf+fw+hOUK/fNiyYOM9f9Um3ocS5kE6utLuvyTxdATLCi3WIaCMIb
         DiSAysT7EJK09KuTCJW4vM3stcJ26UYxDtt8MKsX3zSRZR+BIEUoMic5Dut8Y4q1aYCQ
         F/ACiGQEex14uDXxPZadF5WafBS5qvsnxTTvJuNuRUcJR6MThKYQEQP7WB9d1VFrhHYn
         Og+Q==
X-Gm-Message-State: APjAAAUi9o8i6DunZKpdBV6D/+EEtSa6fyLfRhtAe5ivAwJo9UiJOXor
        mqA2LjkLvYUh0RYxF4i0ltyCPA==
X-Google-Smtp-Source: APXvYqwjJi4PF0tOiJFK9Fzga9qOPXzicdB09KvGaSWb7z0d1TsMp2llrCLtwaNJ06hA69FTJDdx7A==
X-Received: by 2002:a63:5a0a:: with SMTP id o10mr21379964pgb.282.1566237501974;
        Mon, 19 Aug 2019 10:58:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h70sm14930028pgc.36.2019.08.19.10.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:58:21 -0700 (PDT)
Message-ID: <5d5ae33d.1c69fb81.49902.678d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819101238.17335-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-10-niklas.cassel@linaro.org> <20190819101238.17335-1-niklas.cassel@linaro.org>
Subject: Re: [PATCH v3 09/14] dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 10:58:20 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Niklas Cassel (2019-08-19 03:12:38)
> Add qcom-opp bindings with properties needed for Core Power Reduction
> (CPR).
>=20
> CPR is included in a great variety of Qualcomm SoCs, e.g. msm8916 and
> msm8996. CPR was first introduced in msm8974.
>=20
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

