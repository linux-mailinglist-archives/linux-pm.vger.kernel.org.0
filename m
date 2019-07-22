Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56E570C6E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfGVWQr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 18:16:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34128 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfGVWQr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 18:16:47 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so77574189iot.1;
        Mon, 22 Jul 2019 15:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjaIw+OIOqnuVMPluGpxJ5ZQQXD25h9ZXkf8XCLJ1LQ=;
        b=mD8HqbcBaVb+/y5WTUdncVbGGvV1MsirPwtGbhswdJbNVE1vCYNbq+Utk3rU5swfaH
         NqyB/2y1rEwRC2iRnlUc36HuRCU7ChOeH7BQ/ZNJ3bbL/FUTgDaOtpr7tVTzogjlgxe2
         3iT0LXZ5j7Nb8ARLN54cKtsC7gXkKgDCumaLJvMb3oHeM8p0NDwTeZ/AT7V3ab/l//fw
         vgrwD5QsbMET4lAGSFDvLujSP5dk7MId3jxZoSI1OcpGLkhH8gjRMbJrGy6q9RWpwLlr
         Ue2qSe55Vta2CJJ0OBEs412ihWGy20ewAkSVZrltJC2FVirW+hTThi3/gh3ABbYpexu3
         wv0g==
X-Gm-Message-State: APjAAAVRVcKJIYUsqyT0c4/eLL+WBShsWlj1xeQg1EAT4C1EuM502hUj
        mMIYj8UW8WJ9EH5l0obY1w==
X-Google-Smtp-Source: APXvYqweE1pmwMeEtkIP3+qOvfvr0a4dd6g5i87s1QCiHsWjaTPPGkEO/aZ9P3kxWiaUCc8OppzTRA==
X-Received: by 2002:a5d:8747:: with SMTP id k7mr53543542iol.20.1563833806389;
        Mon, 22 Jul 2019 15:16:46 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id x22sm29275248ioh.87.2019.07.22.15.16.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 15:16:45 -0700 (PDT)
Date:   Mon, 22 Jul 2019 16:16:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: thermal: nvme: Add binding
 documentation
Message-ID: <20190722221645.GA32515@bogus>
References: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
 <1561990354-4084-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561990354-4084-3-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 01, 2019 at 11:12:32PM +0900, Akinobu Mita wrote:
> Add thermal binding documentation for NVMe temperature sensor.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> Cc: Kenneth Heitke <kenneth.heitke@intel.com>
> Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> * v5
> - New patch
> 
>  Documentation/devicetree/bindings/thermal/nvme.txt | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/nvme.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/nvme.txt b/Documentation/devicetree/bindings/thermal/nvme.txt
> new file mode 100644
> index 0000000..60b90de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/nvme.txt
> @@ -0,0 +1,56 @@
> +Binding for NVMe temperature sensor
> +
> +An NVMe controller reports up to nine temperature values in the SMART / Health
> +log.
> +
> +Required properties:
> +- reg: A five-cell address encoded as (phys.hi phys.mid phys.lo size.hi
> +  size.lo). phys.hi should contain the device's BDF (Bus/Device/Function)
> +  as 0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.
> +  See also Documentation/devicetree/bindings/pci/pci.txt
> +
> +- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
> +  In the thermal-sensors property, the sensor ID 0 for composite temperature,
> +  1 through 8 for NVMe temperature sensor N.
> +
> +Example:
> +
> +&pcie0 {
> +	...
> +	nvme: nvme@0,0 {
> +		reg = <0x0000 0 0 0 0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		nvmetemp: nvmetemp {
> +			reg = <0x0000 0 0 0 0>; /* DEVFN = 0x00 (0:0) */

I'm not sure this is really valid PCI addressing as the parent has the 
same address.

> +			#thermal-sensor-cells = <1>;

Can't you just put this in the parent? Is this really a separate 
addressable device from the parent?

> +		};
> +	};
> +};
> +
> +&thermal_zones {
> +	nvme_thermal: nvme {
> +		polling-delay-passive = <2000>; /* milliseconds */
> +		polling-delay = <0>; /* asynchronous event driven */
> +
> +				/* sensor	ID */
> +		thermal-sensors = <&nvmetemp	0>;
> +
> +		trips {
> +			nvme_alert0: nvme_alert0 {
> +				temperature = <80000>; /* millicelsius */
> +				hysteresis = <2000>; /* millicelsius */
> +				type = "passive";
> +			};
> +		};
> +
> +		cooling-maps {
> +			map0 {
> +				trip = <&nvme_alert0>;
> +				cooling-device =
> +				<&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.7.4
> 
