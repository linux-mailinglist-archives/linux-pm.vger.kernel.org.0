Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9419A089
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 23:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgCaVOl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 17:14:41 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33879 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgCaVOl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 17:14:41 -0400
Received: by mail-il1-f196.google.com with SMTP id t11so20951703ils.1;
        Tue, 31 Mar 2020 14:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ur4QLOO6ETHe1iKnFSuoEo5LlRhA8voSUwSZFKweEfA=;
        b=m/ej2v/wQmNiHPz4belShNWYZmFZMfVQXDacQ6FK4pIdo2U8voxMG81ZFE7X37+BS+
         2Ti1n/7PG7eK/146Q1YGNoPDZhITvnz99li7Yl5PatV5aI5WtwVFK48tcHG+iEqKmWTx
         h2nVZyKyQLsUJ8UZxNKT0kMD547vDpLuqYSewHmagDbV/InBmNV8yzhVSzB+A9dlG1k+
         WgV8FAbvd7ggjpmOEmimWjIbX6gS9oD1SFAWwjE+lWUkOzdImAvxsY7sT6SgfJ5IpDk2
         inhWMGciXDYE6PlF42w1O686cfyxqeH9OINf4s9Qd043Psiv10mg02u9bsaddGyvVBIE
         kmdw==
X-Gm-Message-State: ANhLgQ3dNhuEF1+wcL2u/0+GcGLk/gR7VJQ6rnORBIG3vwYL/J/uXvul
        FXc4tOcpX0uJIV42bpnvZPS+PKk=
X-Google-Smtp-Source: ADFU+vt6HVqwj8TXAvOZUoaPceHnbmSiHRZAsxIT9WXjZtz31OhRrYnYw3D5uWVwb8e2FCEc99SPNA==
X-Received: by 2002:a92:b0e:: with SMTP id b14mr19624612ilf.176.1585689280450;
        Tue, 31 Mar 2020 14:14:40 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k9sm12982iov.12.2020.03.31.14.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:14:40 -0700 (PDT)
Received: (nullmailer pid 32031 invoked by uid 1000);
        Tue, 31 Mar 2020 21:14:38 -0000
Date:   Tue, 31 Mar 2020 15:14:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: Add yaml bindings for
 thermal sensors
Message-ID: <20200331211438.GA31917@bogus>
References: <cover.1585117436.git.amit.kucheria@linaro.org>
 <93466e6c031c0084de09bd6b448556a6c5080880.1585117436.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93466e6c031c0084de09bd6b448556a6c5080880.1585117436.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Mar 2020 12:04:52 +0530, Amit Kucheria wrote:
> As part of moving the thermal bindings to YAML, split it up into 3
> bindings: thermal sensors, cooling devices and thermal zones.
> 
> The property #thermal-sensor-cells is required in each device that acts
> as a thermal sensor. It is used to uniquely identify the instance of the
> thermal sensor inside the system.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../bindings/thermal/thermal-sensor.yaml      | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
